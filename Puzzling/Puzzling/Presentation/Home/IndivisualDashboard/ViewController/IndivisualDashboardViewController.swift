//
//  IndivisualDashboardViewController.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/10.
//

import UIKit

import Moya
import SnapKit
import Then

final class IndivisualDashboardViewController: UIViewController {
    
    private var tabBarHeight: CGFloat {
        guard let height = self.tabBarController?.tabBar.frame.size.height else {
            return 0.0
        }
        return height
    }
    
    private lazy var actionPlanHeight = view.frame.size.height/3.95
    
    private var indivisualBoardCount: Int = 0
    private var todayString: String = Date().dateToServerString
    private var memberId: Int = 0
    private var projectId: Int = 0
    private var projectTitle: String = ""
    
    let mainView: DashboardMainBoxView = DashboardMainBoxView(frame: .zero, type: .indivisual)
    let actionPlanView = ActionPlanView()
    let homeMainButton = HomeMainButton(frame: .zero, type: .notToday)
    
    private let templateNetworkProvider = MoyaProvider<CreateRetrospectService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setAction()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        mainView.puzzleCollectionView.reloadCollectionView()
//    }
    
    deinit {
        print(className)
    }
}

extension IndivisualDashboardViewController {
        
    private func setUI() {
        view.backgroundColor = .white000
        
        homeMainButton.do {
            $0.addTarget(self, action: #selector(moveToCreateRetrospect), for: .touchUpInside)
        }
    }
    
    private func setLayout() {
        view.addSubviews(mainView, homeMainButton, actionPlanView)
        
        mainView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(2.55)
        }
        
        actionPlanView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(mainView.snp.bottom).offset(30)
            $0.height.equalTo(actionPlanHeight)
        }
        
        homeMainButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(55)
            $0.top.equalTo(actionPlanView.snp.bottom)
        }
    }
    
    private func setAction() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(moveToPuzzleBoardArchive))
        mainView.cardButtonView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func showOffRetrospectButtonAnimation() {
        
    }
}

extension IndivisualDashboardViewController {
    @objc
    private func moveToPuzzleBoardArchive() {
        let puzzleBoardVC = PuzzleBoardViewController()
        puzzleBoardVC.passNavigationTitle(boardType: .indivisual)
        puzzleBoardVC.passPuzzleBoardCount(count: self.indivisualBoardCount)
        self.navigationController?.pushViewController(puzzleBoardVC, animated: true)
    }
    
    @objc
    private func moveToCreateRetrospect() {
        // 수정해야함
        let createRetrospectViewController = CreateReViewViewController()
        createRetrospectViewController.passProjectTitle(title: self.projectTitle)
        self.navigationController?.pushViewController(createRetrospectViewController, animated: true)
    }
}

extension IndivisualDashboardViewController {
    func passBoardCount(count: Int) {
        self.indivisualBoardCount = count
    }
    
    func passUserInformation(memberId: Int, projectId: Int, projectTitle: String) {
        self.projectTitle = projectTitle
        self.memberId = memberId
        self.projectId = projectId
    }
}
