//
//  UITableView+.swift
//  Puzzling-iOS
//
//  Created by KJ on 2023/07/04.
//

import UIKit

extension UITableView {
    
    func registerCell<T: UITableViewCell>(_ type: T.Type) {
        self.register(type.self, forCellReuseIdentifier: type.className)
    }
    
    func registerCells<T: UITableViewCell>(_ types: T.Type...) {
        types.forEach {
            registerCell($0)
        }
    }

    func registerReusableView<T: UITableViewHeaderFooterView>(_ type: T.Type) {
        self.register(type.self, forHeaderFooterViewReuseIdentifier: type.className)
    }
    
    func registerReusableViews<T: UITableViewHeaderFooterView>(_ types: T.Type...) {
        types.forEach {
            registerReusableView($0)
        }
    }
    
    func dequeueCell<T: UITableViewCell>(type: T.Type, indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }

    func dequeueReusableView<T: UITableViewHeaderFooterView>(type: T.Type) -> T {
        return self.dequeueReusableHeaderFooterView(withIdentifier: type.className) as! T
    }
}
