//
//  ViewController.swift
//  Puzzling-iOS
//
//  Created by KJ on 2023/07/04.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private var titleBarView = HomeTitleBarView()
    private let segmentedView = HomeSegmentedView()
    
    private let indivisualDashboardViewController = IndivisualDashboardViewController()
    private let teamDashboardViewController = TeamDashboardViewController()
    private lazy var dashboardViewControllers: [UIViewController] = [indivisualDashboardViewController, teamDashboardViewController]
    
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    private var currentPage: UIViewController!
    
    private var tabBarHeight: CGFloat {
        guard let height = self.tabBarController?.tabBar.frame.size.height else { return 0.0 }
        return height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setUI()
        setLayout()
        setPage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    deinit {
        print(className)
    }
}

extension HomeViewController {
    
    private func setDelegate() {
        titleBarView.delegate = self
//        segmentedView.delegate = self
    }
    
    private func setUI() {
        view.backgroundColor = .white000
        
        pageViewController.do {
            $0.didMove(toParent: self)
        }
    }
    
    private func setLayout() {
        self.addChild(pageViewController)
        view.addSubviews(titleBarView, segmentedView, pageViewController.view)
        
        titleBarView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(48)
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        segmentedView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(50)
            $0.top.equalTo(titleBarView.snp.bottom)
        }
        
        pageViewController.view.snp.makeConstraints {
            $0.top.equalTo(segmentedView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(tabBarHeight)
        }
    }
    
    private func setPage() {
        if let firstViewController = dashboardViewControllers.first {
            pageViewController.setViewControllers([firstViewController], direction: .forward, animated: false)
            currentPage = firstViewController
        }
    }
}

extension HomeViewController: HomeBottomSheetDelegate {
    func popAlarmAction() {
        print("pppopALALALALALARM")
    }
    
    func openBottomSheet() {
        print("OOO")
    }
}

//extension HomeViewController: HomeSegmentDelegate {
//    func movePage(to index: Int) {
//        switch index {
//        case 0:
//            switchPage(difference: 1)
//        case 1:
//            switchPage(difference: -1)
//        default:
//            break
//        }
//    }
    
//    private func switchPage(difference: Int) {
//        guard let page = dashboardViewControllers.firstIndex(of: currentPage) else { return }
//        switch difference {
//        case 1:
//            pageViewController.setViewControllers([dashboardViewControllers[page + difference]], direction: .forward, animated: true)
//        case -1:
//            pageViewController.setViewControllers([dashboardViewControllers[page + difference]], direction: .reverse, animated: true)
//        default:
//            break
//        }
//        currentPage = dashboardViewControllers[page + difference]
//    }
//}
