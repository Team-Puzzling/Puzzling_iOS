//
//  ReviewDetailViewController.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/15.
//

import UIKit

import SnapKit
import Then

extension ReviewDetailViewController {
    @frozen
    enum reviewDetail: CaseIterable {
        case review, empty
        
        var reviewDetailViewStatus: UIView? {
            switch self {
            case .review:
                let v = ReviewDetailView()
                v.reviewCollectionview.reloadData()
                return v
            case .empty:
                return ReviewDetailEmptyView()
            }
        }
    }
}

extension ReviewDetailViewController: reviewDateProtocol {
    func reviewDate(text: String) {
        selectedDate = text
        
        print(selectedDate, "aaaaaa👿👿👿👿👿👿👿👿👿👿👿👿👿👿👿👿👿👿👿👿")
        let userInfo = selectedDate
        print(userInfo, "xxxxxx")
        NotificationCenter.default.post(
            name: Notification.Name("dateNotification"),
            object: nil,
            userInfo: ["userInfo": userInfo]
        )
        reviewDetailView?.layoutSubviews()
    }
}

final class ReviewDetailViewController: UIViewController {
    
    private var selectedDate: String = "2023-07-17"
    
    private let projectCalenderView = ProjectCalendarView()
    
    func setReviewDetailView(status: reviewDetail) {
        print(#function, status)
        reviewDetailView?.alpha = 0
        reviewDetailView?.removeFromSuperview()
        reviewDetailView = nil
        reviewDetailView = status.reviewDetailViewStatus
    }
    
    private var reviewDetailView: UIView? = UIView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setUI()
        setLayout()
        setNotificationCenter()
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
        projectCalenderView.delegate = self
    }
    
    private func setUI() {
        view.backgroundColor = .white000
    }
    
    private func setLayout() {
        view.addSubviews(projectCalenderView)
        
        projectCalenderView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(projectCalenderView.getCalendarViewHeight())
        }
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
    }
    
    private func layout() {
        view.addSubviews(reviewDetailView ?? UIView())
        reviewDetailView?.snp.makeConstraints {
            $0.top.equalTo(projectCalenderView.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(getDateBoolNotification(_:)), name: Notification.Name("dateBoolNotification"), object: nil)
    }
}

extension ReviewDetailViewController {
    @objc
    private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func getDateBoolNotification(_ notification: Notification) {
        if let dateNotification = notification.userInfo?["userInfo"] as? Bool {
            print(dateNotification,"???????")
            if (dateNotification == true) {
                setReviewDetailView(status: .review)
            }
            else { setReviewDetailView(status: .empty) }
        }
        layout()
    }
}
