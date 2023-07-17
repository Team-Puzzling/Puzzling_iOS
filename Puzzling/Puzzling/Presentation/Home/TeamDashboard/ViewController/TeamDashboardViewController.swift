//
//  TeamDashboardViewController.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/10.
//

import UIKit

final class TeamDashboardViewController: UIViewController {
    
    private var tabBarHeight: CGFloat {
        guard let height = self.tabBarController?.tabBar.frame.size.height else {
            print("fffffff")
            return 0.0
        }
        return height
    }
    
    private var deviceHeight: CGFloat {
        let height = view.frame.size.height/3.35
        print(height)
        return height
    }
    
    private let mainScrollView = UIScrollView()
    private let contentView = UIView()
    
    private let mainView: DashboardMainBoxView = DashboardMainBoxView(frame: .zero, type: .team)
    
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
        }
        
        mainView.do {
            $0.passPuzzleData(userName: "심규보봉", piecesCount: 5)
        }
    }
    
    private func setLayout() {
        view.addSubviews(mainScrollView)
        mainScrollView.addSubview(contentView)
        
        contentView.addSubviews(mainView)
        
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
            $0.height.equalTo(deviceHeight)
            $0.bottom.equalToSuperview()
        }
    }
}
