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
    private let reviewDetailView = ReviewDetailView()
    private let reviewDetailEmptyView = ReviewDetailEmptyView()
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setCalendarViewLayout()
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

    }
    
    private func setLayout() {
        view.addSubviews(projectCalenderView, reviewDetailEmptyView)
        
        projectCalenderView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.height.equalTo(300)
        }
        
        reviewDetailEmptyView.snp.makeConstraints {
            $0.top.equalTo(projectCalenderView.snp.bottom).offset(12)
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
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
        
        navigationItem.leftBarButtonItem?.tintColor = .gray500
        
        let title = "프로젝트 1"
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.black000,
            NSAttributedString.Key.font: UIFont.fontGuide(.heading4_kor)
        ]
        
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.attributedText = NSAttributedString(string: title, attributes: attributes)
        } else {
            let titleLabel = UILabel()
            titleLabel.attributedText = NSAttributedString(string: title, attributes: attributes)
            navigationItem.titleView = titleLabel
        }
    }
    
    private func setCalendarViewLayout() {
        projectCalenderView.snp.remakeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.height.equalTo(projectCalenderView.getCalendarViewHeight())
        }
        
        reviewDetailEmptyView.snp.remakeConstraints {
            $0.top.equalTo(projectCalenderView.snp.bottom).offset(12)
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }
}

extension ReviewDetailViewController {
    @objc
    private func backButtonTapped() {
        
    }
}
