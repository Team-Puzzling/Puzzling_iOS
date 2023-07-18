//
//  TeamDashboardViewController.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/10.
//

import UIKit

final class TeamDashboardViewController: UIViewController {
    
    private let mainScrollView = UIScrollView()
    private let contentView = UIView()
    
    private let mainView: DashboardMainBoxView = DashboardMainBoxView(frame: .zero, type: .team)
    private var teamRankView = TeamDashboardRankView()
    
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
    
    private let projectService = ProjectServiceTemporary()
    private lazy var sortedData: [TeamRankModel] = projectService.getSortedData()
    
    private var scrollViewHeight: CGFloat {
        let height:CGFloat = view.frame.size.height/4.06
        let totalHeight: CGFloat = height + CGFloat(sortedData.count - 3) * 52 + 10
        return totalHeight
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setUI()
        setLayout()
    }
    
    deinit {
        print(className)
    }
}

extension TeamDashboardViewController {
    
    private func setDelegate() {
        
    }
    
    private func setUI() {
        view.backgroundColor = .white000
        
        mainScrollView.do {
            $0.isScrollEnabled = true
            $0.showsVerticalScrollIndicator = false
            $0.bouncesZoom = true
        }
        
        mainView.do {
            $0.passPuzzleData(userName: "심규보봉", piecesCount: 5)
        }
        
        teamRankView.do {
            $0.passProjectName(projectName: "더퍼즐링s")
        }
    }
    
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
}
