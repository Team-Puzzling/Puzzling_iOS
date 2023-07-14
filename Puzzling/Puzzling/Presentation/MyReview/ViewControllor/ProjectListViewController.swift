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
    
    weak var delegate: projectNameProtocol?
    private let myProjectData = MyProjectDataModel.dummy()
    // MARK: - Properties
    
    private let modalView = UIView()
    private let tableView = UITableView(frame: .zero, style: .grouped)
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
            $0.backgroundColor = .blue100
        }
        
        tableView.do {
            $0.separatorStyle = .none
            $0.backgroundColor = .white000
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
            $0.bottom.equalToSuperview().inset(98)
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    
    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
//    func setModalView(height: CGFloat) {
//        UIView.animate(withDuration: 0.3) {
//            self.modalView.snp.remakeConstraints {
//                $0.height.equalTo(height)
//                $0.leading.trailing.bottom.equalToSuperview()
//            }
//            self.view.layoutIfNeeded()
//        }
//    }
    private func setRegister() {
        print("🥲🥲🥲🥲🥲")
        tableView.registerCell(ProjectNameTableViewCell.self)
    }
    
    deinit {
        print("\(className)deinit")
    }
}

extension ProjectListViewController: UITableViewDelegate {}

extension ProjectListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(myProjectData.count)
        return myProjectData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(type: ProjectNameTableViewCell.self, indexPath: indexPath)
        cell.setDataBind(name: myProjectData[indexPath.row].projectName)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
