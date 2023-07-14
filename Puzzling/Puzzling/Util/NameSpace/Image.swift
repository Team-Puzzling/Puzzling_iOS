//
//  Image.swift
//  Puzzling-iOS
//
//  Created by KJ on 2023/07/04.
//

import UIKit

public enum Image {
    
    // MARK: - TabBar
    
    static let deselectedHome = UIImage(named: "deselectedHome")!
    static let selectedHome = UIImage(named: "selectedHome")!
    static let selectedPerson = UIImage(named: "selectedPerson")!
    static let deselectedPerson = UIImage(named: "deselectedPerson")!
    
    // MARK: - Icon
    
    static let xMark = UIImage(named: "xMark")!
    static let textFieldXMark = UIImage(named: "textFieldXMark")!
    static let chevronDown = UIImage(named: "chevronDown")!
    static let chevronBack = UIImage(named: "chevronBack")!
    static let defaultPuzzle = UIImage(named: "defaultPuzzle")!
    static let notificationBell = UIImage(named: "notificationBell")!
    static let notification = UIImage(named: "bell1")!
    static let warning = UIImage(named: "warning")!
    static let downIcon = UIImage(systemName: "chevron.down")?
        .withTintColor(.gray500, renderingMode: .alwaysOriginal)
    static let upIcon = UIImage(systemName: "chevron.up")?
        .withTintColor(.gray500, renderingMode: .alwaysOriginal)
    static let leftIcon = UIImage(systemName: "chevron.left")?
        .withTintColor(.label, renderingMode: .alwaysOriginal)
    static let rightIcon = UIImage(systemName: "chevron.right")?
        .withTintColor(.label, renderingMode: .alwaysOriginal)
    
    // MARK: - Rank
    
    static let rank1st = UIImage(named: "rank1st")!
    static let rank2nd = UIImage(named: "rank2nd")!
    static let rank3rd = UIImage(named: "rank3rd")!
}
