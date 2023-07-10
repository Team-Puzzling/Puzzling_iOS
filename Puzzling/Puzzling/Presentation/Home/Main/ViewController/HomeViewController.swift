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
}

extension HomeViewController {
    
    private func setDelegate() {
        pageViewController.dataSource = self
        pageViewController.delegate = self
        titleBarView.delegate = self
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
            $0.height.equalTo(60)
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
        }
        
        for view in self.pageViewController.view.subviews {
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = false
            }
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

extension HomeViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = dashboardViewControllers.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        return dashboardViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = dashboardViewControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == dashboardViewControllers.count {
            return nil
        }
        return dashboardViewControllers[nextIndex]
    }
}
