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
    
    // MARK: - Properties
    
    private let modalView = UIView()
    private let tableView = UITableView(frame: .zero, style: .grouped)
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setUI()
        setLayout()
    }
    
    private func setDelegate() {
        
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
    
//    func setModalView(height: CGFloat) {
//        UIView.animate(withDuration: 0.3) {
//            self.modalView.snp.remakeConstraints {
//                $0.height.equalTo(height)
//                $0.leading.trailing.bottom.equalToSuperview()
//            }
//            self.view.layoutIfNeeded()
//        }
//    }
//
    func dismissBottomSheet() {
        dismiss(animated: true, completion: nil)
    }
    
    deinit {
        print("\(className)deinit")
    }
}
