//
//  HomeMainButton.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/12.
//

import UIKit

final class HomeMainButton: UIButton {

    private var isButtonEnabled: Bool = false {
        didSet {
            if isButtonEnabled == true {
                self.isEnabled = true
            } else {
                self.isEnabled = false
            }
        }
    }
    
    enum ButtonType {
        case notToday
        case today
        case done
        
        var buttonTitle: String {
            switch self {
            case .notToday:
                return "회고 작성일이 아니에요"
            case .today, .done:
                return "회고 작성하기"
            }
        }
        
        var buttonColor: UIColor {
            switch self {
            case .notToday, .done:
                return .gray400
            case .today:
                return .blue400
            }
        }
    }
    
    private let buttonTitle: String
    private let buttonBackgroundColor: UIColor
    
    init(frame: CGRect, type: ButtonType) {
        self.buttonTitle = type.buttonTitle
        self.buttonBackgroundColor = type.buttonColor
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeMainButton {

    private func setUI() {
        self.isEnabled = false
        self.backgroundColor = buttonBackgroundColor
        self.layer.cornerRadius = 16
        self.setTitle(buttonTitle, for: .normal)
        self.titleLabel?.font = .fontGuide(.heading4_kor)
    }
}

extension HomeMainButton {
    func enableButton(to bool: Bool) {
        if bool == true {
            self.isButtonEnabled = true
        } else {
            self.isButtonEnabled = false
        }
    }
}
