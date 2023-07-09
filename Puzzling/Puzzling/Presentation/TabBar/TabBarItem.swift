//
//  TabBarItem.swift
//  Puzzling
//
//  Created by KJ on 2023/07/08.
//

import UIKit

enum TabBarItemType: Int, CaseIterable {
    case home
    case myPage
}

extension TabBarItemType {
    
    var title: String {
        switch self {
        case .home:
            return "홈"
        case .myPage:
            return "마이페이지"
        }
    }
    
    var unSelectedIcon: UIImage {
        switch self {
        case .home:
            return Image.home
        case .myPage:
            return Image.myPage
        }
    }
    
    var selectedIcon: UIImage {
        switch self {
        case .home:
            return Image.selectedHome
        case .myPage:
            return Image.myPage
        }
    }
    
    public func setTabBarItem() -> UITabBarItem {
        return UITabBarItem(title: title, image: unSelectedIcon, selectedImage: selectedIcon)
    }
}
