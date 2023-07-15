//
//  ReviewDetailViewController.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/15.
//

import UIKit

import SnapKit
import Then

final class ReviewDetailViewController: UIViewController {
    
    private let projectCalenderView = ProjectCalendarView()
    private let teamMemberTableView = UITableView(frame: .zero, style: .grouped)
    
    private let teamMemberData = TeamMemberDataModel.dummy()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setUI()
        setLayout()
        setRegister()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }
    
    deinit {
        print(className)
    }
}

extension ReviewDetailViewController {
    
    private func setDelegate() {

    }
    
    private func setUI() {
        view.backgroundColor = .white000
        teamMemberTableView.do {
            $0.separatorStyle = .none
            $0.backgroundColor = .clear
        }
    }
    
    private func setLayout() {
        view.addSubviews(projectCalenderView)
        
        projectCalenderView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.height.equalTo(300)
        }
    }
    
    private func setRegister() {
    }
    
    private func setNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: Image.chevronBackIcon,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        let title = "프로젝트 1"
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.black000,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]
        
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.attributedText = NSAttributedString(string: title, attributes: attributes)
        } else {
            let titleLabel = UILabel()
            titleLabel.attributedText = NSAttributedString(string: title, attributes: attributes)
            navigationItem.titleView = titleLabel
        }
    }
}

extension ReviewDetailViewController {
    @objc
    private func backButtonTapped() {
        
    }
}
