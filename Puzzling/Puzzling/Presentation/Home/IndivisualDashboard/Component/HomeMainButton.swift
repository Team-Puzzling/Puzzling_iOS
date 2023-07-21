//
//  HomeMainButton.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/12.
//

import UIKit

final class HomeMainButton: UIButton {
    
    // MARK: - Properties

    private var isButtonEnabled: Bool = false {
        didSet {
            if isButtonEnabled == true {
                self.isEnabled = true
            } else {
                self.isEnabled = false
            }
        }
    }
    
    private var type: ButtonType {
        didSet {
            switch type {
            case .notToday:
                self.setTitle(type.buttonTitle, for: .normal)
                self.backgroundColor = type.buttonColor
                self.isEnabled = false
            case .today:
                self.setTitle(type.buttonTitle, for: .normal)
                self.backgroundColor = type.buttonColor
                self.isEnabled = true
            case .done:
                self.setTitle(type.buttonTitle, for: .normal)
                self.backgroundColor = type.buttonColor
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
    
    // MARK: - Initializer
    
    init(frame: CGRect, type: ButtonType) {
        self.buttonTitle = type.buttonTitle
        self.buttonBackgroundColor = type.buttonColor
        self.type = type
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeMainButton {
    
    // MARK: - UI Components Property

    private func setUI() {
        self.isEnabled = false
        self.backgroundColor = buttonBackgroundColor
        self.layer.cornerRadius = 16
        self.setTitle(buttonTitle, for: .normal)
        self.titleLabel?.font = .fontGuide(.heading4_kor)
        self.setTitleColor(.white000, for: .normal)
    }
}

extension HomeMainButton {
    
    // MARK: - Methods
    
    func enableButton(toType: ButtonType) {
        self.type = toType
    }
}
