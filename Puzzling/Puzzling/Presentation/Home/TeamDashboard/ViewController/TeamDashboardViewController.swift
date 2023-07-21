//
//  TeamDashboardViewController.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/10.
//

import UIKit

import SnapKit
import Then

final class TeamDashboardViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let mainScrollView = UIScrollView()
    private let contentView = UIView()
    let mainView: DashboardMainBoxView = DashboardMainBoxView(frame: .zero, type: .team)
    var teamRankView = TeamDashboardRankView()
    
    // MARK: - Properties
    
    private var teamArray: [TeamProjectRank] = []
    private var teamBoardCount: Int = 0
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setAction()
    }
    
    deinit {
        print(className)
    }
}

extension TeamDashboardViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        view.backgroundColor = .white000
        
        mainScrollView.do {
            $0.isScrollEnabled = true
            $0.showsVerticalScrollIndicator = false
            $0.bouncesZoom = true
        }
        
        mainView.do {
            $0.isUserInteractionEnabled = true
//            $0.card
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        view.addSubviews(mainScrollView)
        mainScrollView.addSubview(contentView)
        
        contentView.addSubviews(mainView, teamRankView)
        
        mainScrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.centerX.top.bottom.equalToSuperview()
        }
        
        mainView.snp.makeConstraints {
            $0.horizontalEdges.top.equalToSuperview()
            $0.height.equalTo(mainViewHeight)
        }
        
        teamRankView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(mainView.snp.bottom).offset(30)
            $0.height.equalTo(scrollViewHeight)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    private func setAction() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(moveToPuzzleBoardArchive))
        mainView.cardButtonView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private var tabBarHeight: CGFloat {
        guard let height = self.tabBarController?.tabBar.frame.size.height else {
            return 0.0
        }
        return height
    }
    
    private var mainViewHeight: CGFloat {
        let height = view.frame.size.height/3.35
        return height
    }
    
    private var scrollViewHeight: CGFloat {
        let height:CGFloat = view.frame.size.height/4.06
        let sortHeight = CGFloat(teamArray.count - 3)
        
        if sortHeight < 0 {
            return height + 10
        } else {
            return height + sortHeight * 52 + 10
        }
    }
}

extension TeamDashboardViewController {
    func passTeamArray(data: [TeamProjectRank]) {
        self.teamArray = data
    }
}

extension TeamDashboardViewController {
    @objc
    private func moveToPuzzleBoardArchive() {
        let puzzleBoardVC = PuzzleBoardViewController()
        puzzleBoardVC.passNavigationTitle(boardType: .team)
        puzzleBoardVC.passPuzzleBoardCount(count: self.teamBoardCount)
        self.navigationController?.pushViewController(puzzleBoardVC, animated: true)
    }
}

extension TeamDashboardViewController {
    func passBoardCount(count: Int) {
        self.teamBoardCount = count
    }
}
