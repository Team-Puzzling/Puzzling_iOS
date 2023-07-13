//
//  ProjectListViewController.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/14.
//

import UIKit

import Then

final class ProjectListViewController: UIViewController {
    
    // MARK: - Properties
    
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
            sheetPresentationController.preferredCornerRadius = 20
            sheetPresentationController.detents = [.custom { context in
                return context.maximumDetentValue * 0.33
            }]
        }
        view.backgroundColor = .white000
        
        tableView.do {
            $0.separatorStyle = .none
            $0.backgroundColor = .clear
        }
    }
    
    private func setLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(60)
            $0.bottom.equalToSuperview().inset(98)
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    func dismissBottomSheet() {
        dismiss(animated: true, completion: nil)
    }
    
    deinit {
        print("\(className)deinit")
    }
}
