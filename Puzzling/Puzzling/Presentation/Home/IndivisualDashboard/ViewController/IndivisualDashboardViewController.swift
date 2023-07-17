//
//  IndivisualDashboardViewController.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/10.
//

import UIKit

final class IndivisualDashboardViewController: UIViewController {

    private var tabBarHeight: CGFloat {
        guard let height = self.tabBarController?.tabBar.frame.size.height else {
            return 0.0
        }
        return height
    }
    
    private let mainView: DashboardMainBoxView = DashboardMainBoxView(frame: .zero, type: .indivisual)
    private let actionPlanView = ActionPlanView()
    private var homeMainButton = HomeMainButton(frame: .zero, type: .notToday)
    
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

extension IndivisualDashboardViewController {
    
    private func setDelegate() {}
    
    private func setUI() {
        view.backgroundColor = .white000
        
        mainView.do {
            $0.passPuzzleData(userName: "심규보봉", piecesCount: 5)
        }
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
}
