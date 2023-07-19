//
//  ProjectListViewController.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/14.
//

import UIKit

import SnapKit
import Then
import Moya

protocol projectNameProtocol: AnyObject {
    func nameData(text: String)
}

final class ProjectListViewController: UIViewController {
    
    private var projectName: String = "Project1"
    
    weak var delegate: projectNameProtocol?
    
    private let myProjectProvider = MoyaProvider<MyProjectService>(plugins:[NetworkLoggerPlugin()])
    
    private var myProjectData: [ProjectListResponse] = []
    
    // MARK: - Properties
    
    private let modalView = UIView()
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setDelegate()
        setRegister()
        fetchProjectList()
    }
    
    deinit {
        print(className)
    }
}

extension ProjectListViewController {

    private func setUI() {
        
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.preferredCornerRadius = 16
        }
        
        modalView.do {
            $0.backgroundColor = .white000
        }
        
        tableView.do {
            $0.separatorStyle = .none
            $0.backgroundColor = .background050
        }
    }
    
    private func setLayout() {
        view.addSubview(modalView)
        modalView.addSubview(tableView)
        modalView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(60)
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setRegister() {
        tableView.registerCell(ProjectNameTableViewCell.self)
    }
}

extension ProjectListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        projectName = myProjectData[indexPath.row].projectName
        self.delegate?.nameData(text: myProjectData[indexPath.row].projectName)
        self.dismiss(animated: true)
    }
}

extension ProjectListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myProjectData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(type: ProjectNameTableViewCell.self, indexPath: indexPath)
        let nameData = myProjectData[indexPath.row].projectName
        let projectId = myProjectData[indexPath.row].projectId
        cell.setDataBind(id: projectId, name: nameData)
        
        if nameData == projectName {
            cell.setPointLabel()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension ProjectListViewController {
    func setProjectName(projectName: String) {
        self.projectName = projectName
    }
}

extension ProjectListViewController {
    
    // MARK: - Network
    
    private func fetchProjectList() {
        guard let memberId = UserDefaults.standard.string(forKey: "memberId") else { return }
        print(memberId)
        myProjectProvider.request(.projectList(memberId: "2")) { result in
            switch result {
            case .success(let result):
                let status = result.statusCode
                print(status)
                if status >= 200 && status < 300 {
                    do {
                        guard let data = try result.map(GeneralResponse<[ProjectListResponse]>.self).data else { return }
                        self.myProjectData = data
                        self.tableView.reloadData()
                        print("♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️")
                        
                        
                    } catch(let error) {
                        print(error.localizedDescription)
                    }
                } else if status == 404 {
                    print("💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
