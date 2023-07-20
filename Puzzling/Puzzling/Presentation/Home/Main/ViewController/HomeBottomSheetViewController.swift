//
//  HomeBottomSheetViewController.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/19.
//

import UIKit

import SnapKit
import Then

protocol HomeBottomSheetPassNewProjectDelegate: AnyObject {
    func changeProjectId(to newId: Int)
}

final class HomeBottomSheetViewController: UIViewController {
    
    weak var delegate: HomeBottomSheetPassNewProjectDelegate?
    
    private var existingProjectsArray: [OngoingProjectData] = []
    private var currentProjectId: Int?
    private var currentProjectTitle: String?
    
    private let projectTableView = UITableView()
    private let createProjectButton = HomeBottomSheetCellButton(frame: .zero, buttonTitle: HomeBottomViewButtonType.create.title)
    private let joinProjectButton = HomeBottomSheetCellButton(frame: .zero, buttonTitle: HomeBottomViewButtonType.join.title)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setUI()
        setLayout()
        setAction()
    }
    
    deinit {
        print(className)
    }
}

extension HomeBottomSheetViewController {
    private func setDelegate() {
        projectTableView.delegate = self
        projectTableView.dataSource = self
    }
    
    private func setUI() {
        view.backgroundColor = .white000
        
        projectTableView.do {
            $0.rowHeight = 60
            $0.register(HomeBottomSheetTableViewCell.self, forCellReuseIdentifier: "bottomSheet")
            $0.isScrollEnabled = true
            $0.isUserInteractionEnabled = true
        }
    }
    
    private func setLayout() {
        view.addSubviews(projectTableView, createProjectButton, joinProjectButton)
        
        projectTableView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(60)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(getTableViewHeight())
        }
        
        createProjectButton.snp.makeConstraints {
            $0.top.equalTo(projectTableView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        joinProjectButton.snp.makeConstraints {
            $0.top.equalTo(createProjectButton.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(60)
        }
    }
    
    private func getTableViewHeight() -> CGFloat {
        let tableViewHeight: CGFloat
        if existingProjectsArray.count < 5 {
            tableViewHeight = CGFloat(existingProjectsArray.count * 60)
            return tableViewHeight
        } else {
            return 240
        }
    }
    
    private func setAction() {
        // Button -> didsmiss 하고 Navigation?
    }
}

extension HomeBottomSheetViewController {
    func passOngoingProjectsData(projects: [OngoingProjectData], currentId: Int, currentProjectTitle: String) {
        self.existingProjectsArray = projects
        self.currentProjectId = currentId
        self.currentProjectTitle = currentProjectTitle
    }
}

extension HomeBottomSheetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return existingProjectsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "bottomSheet", for: indexPath) as? HomeBottomSheetTableViewCell else {
            return UITableViewCell() }
        cell.selectionStyle = .none
        guard let currentProjectId else {
            return UITableViewCell() }
        if currentProjectId == existingProjectsArray[indexPath.row].projectId {
            cell.setDataBind(project: existingProjectsArray[indexPath.row], isCurrentProject: true)
            return cell
        } else {
            cell.setDataBind(project: existingProjectsArray[indexPath.row], isCurrentProject: false)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? HomeBottomSheetTableViewCell else { return }
        guard let newProjectId = cell.getServiceParameter() else { return }
        print("🚩🚩🚩")
        print("newId: \(newProjectId)")
        print("🚩🚩🚩")
        if let originalId = currentProjectId {
            if originalId == newProjectId {
                print("🚩🚩🚩🚩🚩🚩🚩🚩🚩🚩🚩")
                self.dismiss(animated: true)
            } else {
                self.delegate?.changeProjectId(to: newProjectId)
                
                print(newProjectId)
                print("🚩🚩🚩🚩🚩🚩🍕🚩🚩🚩🚩🚩")
                self.dismiss(animated: true)
            }
        } else {
            print("Cell doesn't have intact Information.")
            self.dismiss(animated: true)
        }
    }
}
