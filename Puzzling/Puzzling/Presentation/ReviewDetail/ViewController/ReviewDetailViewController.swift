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
    
    enum reviewDetail {
        case review
        case empty
    }
    
    // MARK: - UI Components
    
    private let projectCalenderView = ProjectCalendarView()
    private var reviewDetailView: DetailTypeView?
    
    // MARK: - Properties
    
    private var currentProjectTitle: String = "Project1"
    private var currentProjectId: Int = 0
    private var detailType: reviewDetail = .review
    private var selectedDate: String = ""
    private var navigationBool: Bool = false
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setUI()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        projectCalenderView.selectDate(date: self.selectedDate)
        projectCalenderView.calendarView.reloadData()
        if navigationBool == false {
            setNavigationBar()
        } else {
            setTodayNavigation(title: self.currentProjectTitle)
        }
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
}

extension ReviewDetailViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        view.backgroundColor = .white000
    }
    
    // MARK: - Layout Helper
    
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
    
    // MARK: - Methods
    
    private func setDelegate() {
        projectCalenderView.delegate = self
    }
    
    private func setNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: Image.chevronBackIcon,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        navigationItem.leftBarButtonItem?.tintColor = .gray500
        
        let title = currentProjectTitle
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
    
    private func setTodayNavigation(title: String) {
        self.navigationItem.hidesBackButton = true
//        self.navigationItem.backBarButtonItem?.isHidden = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: Image.xMark,
            style: .plain,
            target: self,
            action: #selector(gotoTabBar)
        )
        navigationItem.rightBarButtonItem?.tintColor = .gray500
        
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
}

extension ReviewDetailViewController {
    
    // MARK: - @objc Methods
    
    @objc
    private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func gotoTabBar() {
        UIViewController.modifyRootViewController(TabBarController())
//        let mainViewController = TabBarController()
//        let navigationController = UINavigationController(rootViewController: mainViewController)
//        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
//        guard let delegate = sceneDelegate else {
//            // 에러 알림
//            return
//        }
//        delegate.window?.rootViewController = navigationController
    }
}

extension ReviewDetailViewController: StringTransferDelegate {
    func passString(_ value: String) {
        selectedDate = value
        projectCalenderView.selectDate(date: selectedDate)
    }
}

extension ReviewDetailViewController: reviewDateProtocol {
    func reviewDate(reviewDetailModel: ReviewDetailModel) {
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

extension ReviewDetailViewController {
    func passData(id: Int, title: String) {
        self.currentProjectTitle = title
        self.currentProjectId = id
    }

    func sendTitle(_ title: String, date: String) {
        navigationBool = true
        self.selectedDate = date
        self.currentProjectTitle = title
        self.navigationBool = false
    }
    
    func sendTitleFromCreateReview(title: String, date: String, isFromCreationView: Bool = true) {
        self.selectedDate = date
        self.currentProjectTitle = title
        self.navigationBool = isFromCreationView
    }
}
