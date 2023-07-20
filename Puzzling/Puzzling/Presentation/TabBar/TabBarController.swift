//
//  TabBarController.swift
//  Puzzling
//
//  Created by KJ on 2023/07/08.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - Properties
    
    private var tabs: [UIViewController] = []
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarUI()
        setTabBarItems()
    }
}

extension TabBarController {
    
    private func setTabBarItems() {
        
        tabs = [
            HomeViewController(),
            MyProjectViewController()
        ]
        
        TabBarItemType.allCases.forEach {
            let tabBarItem = $0.setTabBarItem()
//            tabBarItem.imageInsets = UIEdgeInsets(top: 12, left: 0, bottom: -12, right: 0)
//            tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 12)
            tabs[$0.rawValue].tabBarItem = tabBarItem
            tabs[$0.rawValue].tabBarItem.tag = $0.rawValue
        }
        
        setViewControllers(tabs, animated: false)
    }
    
    private func setTabBarUI() {
        UITabBar.clearShadow()
        tabBar.layer.masksToBounds = false
        tabBar.layer.shadowOpacity = 0.2
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 0.7
    }
}
