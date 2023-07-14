//
//  ProjectListViewController.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/14.
//

import UIKit

import Then

protocol projectNameProtocol: AnyObject {
    func nameData(text: String)
}

final class ProjectListViewController: UIViewController {
    
    private var projectName: String = "Project1"
    weak var delegate: projectNameProtocol?
    private let myProjectData = MyProjectDataModel.dummy()
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
    }
    
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
    
    deinit {
        print("\(className)deinit")
    }
}

extension ProjectListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row) 눌럿음")
        projectName = myProjectData[indexPath.row].projectName
        print("\(projectName)?????????????????????")
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
//        print("\( myProjectData[indexPath.row].projectName)     \(projectName)")
        let nameData = myProjectData[indexPath.row].projectName
        cell.setDataBind(name: nameData)
        print("----🧩----")
        print(#function, projectName)
        print(myProjectData[indexPath.row].projectName)
        print(indexPath.row)
        print("---------------------")
        
        if nameData == projectName {
            print("🍀🍀🍀")
            print(nameData)
            print(indexPath.row)
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
