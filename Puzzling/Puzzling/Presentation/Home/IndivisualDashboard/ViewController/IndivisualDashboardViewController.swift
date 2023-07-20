//
//  IndivisualDashboardViewController.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/10.
//

import UIKit

import Moya

final class IndivisualDashboardViewController: UIViewController {
    
    private var tabBarHeight: CGFloat {
        guard let height = self.tabBarController?.tabBar.frame.size.height else {
            return 0.0
        }
        return height
    }
    
    private var indivisualBoardCount: Int = 0
    private var todayString: String = Date().dateToServerString
    
    let mainView: DashboardMainBoxView = DashboardMainBoxView(frame: .zero, type: .indivisual)
    let actionPlanView = ActionPlanView()
    let homeMainButton = HomeMainButton(frame: .zero, type: .notToday)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setAction()
//        jumpWhenStartPuzzleAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView.puzzleCollectionView.reloadCollectionView()
    }
    
    deinit {
        print(className)
    }
}

extension IndivisualDashboardViewController {
        
    private func setUI() {
        view.backgroundColor = .white000
    }
    
    private func setLayout() {
        view.addSubviews(mainView, homeMainButton, actionPlanView)
        
        mainView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(2.55)
        }
        
        homeMainButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(55)
            $0.bottom.equalToSuperview().inset(tabBarHeight + 19)
        }
        
        actionPlanView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(mainView.snp.bottom).offset(30)
            $0.bottom.equalTo(homeMainButton.snp.top).offset(-49)
        }
    }
    
    private func setAction() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(moveToPuzzleBoardArchive))
        mainView.cardButtonView.addGestureRecognizer(tapGestureRecognizer)
    }
    
//    private func jumpWhenStartPuzzleAnimation() {
//        let jumpAnimation = CAKeyframeAnimation(keyPath: "position.y")
//        jumpAnimation.values = [0, -10, 5, -4, 3, 0]
//        jumpAnimation.keyTimes = [0, 0.15, 0.22, 0.34, 0.5, 0.55]
//        jumpAnimation.duration = 0.55
//        jumpAnimation.repeatCount = 2
//        jumpAnimation.fillMode = .forwards
//        jumpAnimation.isRemovedOnCompletion = false
//        jumpAnimation.isAdditive = true
//        mainView.puzzleCollectionView.layer.add(jumpAnimation, forKey: "jumpWhenStart")
//    }
    
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
}

extension IndivisualDashboardViewController {
    func passBoardCount(count: Int) {
        self.indivisualBoardCount = count
    }
}
