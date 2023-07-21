//
//  ReviewDetailViewController.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/15.
//

import UIKit

import SnapKit
import Then

protocol DetailViewType {}

final class ReviewDetailViewController: UIViewController {
    
    enum reviewDetail: CaseIterable {
        case review, empty
    }
    
    private var detailType: reviewDetail = .review
    private var selectedDate: String = "2023-07-17"
    private let projectCalenderView = ProjectCalendarView()
    
    private func removeReviewDetailView(status: reviewDetail) {
        reviewDetailView?.alpha = 0
        reviewDetailView?.removeFromSuperview()
        reviewDetailView = nil
        detailType = status
    }
    
    private func addReviewDetailView(data: ReviewDetailModel?) {
        guard let data else { return }
        reviewDetailView = ReviewDetailView()
        reviewDetailView?.setDataBind(data: data)
        
        view.addSubview(reviewDetailView ?? UIView())
        
        reviewDetailView?.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(160)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    private func addEmptyView() {
        reviewDetailView = ReviewDetailEmptyView()
        
        view.addSubview(reviewDetailView ?? UIView())
        
        reviewDetailView?.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(160)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    private var reviewDetailView: DetailTypeView?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setUI()
        setLayout()
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
    
    private func setCalendarViewLayout() {
        projectCalenderView.snp.remakeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.height.equalTo(projectCalenderView.getCalendarViewHeight())
        }
    }
}

extension ReviewDetailViewController: UIGestureRecognizerDelegate {
    
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
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
}

extension ReviewDetailViewController {
    @objc
    private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
//    @objc
//    private func getDateBoolNotification(_ notification: Notification) {
//        if let dateNotification = notification.userInfo?["userInfo"] as? Bool {
//            print(dateNotification,"???????")
//            if (dateNotification == true) {
//                setReviewDetailView(status: .review)
//            }
//            else { setReviewDetailView(status: .empty) }
//        }
//        layout()
//    }
}

extension ReviewDetailViewController: StringTransferDelegate {
    func passString(_ value: String) {
        selectedDate = value
        print(selectedDate, "🧢🧢🧢🧢🧢🧢🧢🧢🧢🧢🧢🧢🧢")
        projectCalenderView.selectDate(date: selectedDate)
    }
}

extension ReviewDetailViewController: reviewDateProtocol {
    func reviewDate(reviewDetailModel: ReviewDetailModel) {
        print(")_*(_*_*")
        let isDetailViewEmpty = reviewDetailModel.reviewId == nil
        if isDetailViewEmpty == false {
            removeReviewDetailView(status: .empty)
            addReviewDetailView(data: reviewDetailModel)
        }
        else {
            removeReviewDetailView(status: .review)
            addEmptyView()
        }
    }
}
