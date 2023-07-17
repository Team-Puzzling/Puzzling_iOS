//
//  CheckButton.swift
//  Puzzling
//
//  Created by KJ on 2023/07/12.
//

import UIKit

enum CheckButtonState {
    case allow
    case notAllow
}

final class CheckButton: UIButton {
    
    // MARK: - Initializer
    
    init() {
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components Property
    
    func setUI() {
        layer.cornerRadius = 16
        titleLabel?.font = .fontGuide(.heading4_kor)
        setTitleColor(.white000, for: .normal)
        setState(.notAllow)
    }
    
    // MARK: - Methods
    
    public func setState(_ state: CheckButtonState) {
        if state == .allow {
            backgroundColor = .blue400
            isUserInteractionEnabled = true
        } else {
            backgroundColor = .gray400
            isUserInteractionEnabled = false
        }
    }
}

