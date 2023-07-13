//
//  InputContentView.swift
//  Puzzling
//
//  Created by KJ on 2023/07/11.
//

import UIKit

import SnapKit
import Then

enum InputContentType: CaseIterable {
    case name
    case description
    case role
    case nickname
}

final class InputContentView: UIView {
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel()
    private let inputTextField = UITextField()
    private let countLabel = UILabel()
    private let textFieldButtonView = UIView()
    private let removeTextButton = UIButton()
    
    // MARK: - Properties
    
    var activeTextField: InputContentType?
    
    // MARK: - Initializer
    
    init(type: InputContentType) {
        super.init(frame: .zero)
        setUI()
        setLayout()
        setDelegate()
        setInputContent(type: type)
        activeTextField = type
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InputContentView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        backgroundColor = .white000
        
        titleLabel.do {
            $0.font = .fontGuide(.body1_bold_kor)
            $0.textColor = .black000
        }
        
        inputTextField.do {
            $0.backgroundColor = .background050
            $0.textColor = .black000
            $0.font = .fontGuide(.body2_regular_kor)
            $0.setLeftPaddingPoints(16)
            $0.setRightPaddingPoints(16)
            $0.makeCornerRadius(ratio: 16)
            $0.rightView = textFieldButtonView
        }
        
        countLabel.do {
            $0.font = .fontGuide(.detail1_regular_kor)
            $0.textColor = .gray400
        }
        
        removeTextButton.do {
            $0.setImage(Image.textFieldXMark, for: .normal)
            $0.isHidden = true
            $0.addTarget(self, action: #selector(removeTextButtonDidTap), for: .touchUpInside)
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        textFieldButtonView.addSubview(removeTextButton)
        addSubviews(titleLabel, inputTextField, countLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(8)
        }
        
        inputTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(49)
        }
        
        textFieldButtonView.snp.makeConstraints {
            $0.width.equalTo(36)
            $0.height.equalTo(22)
        }
        
        removeTextButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(22)
        }
        
        countLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(8)
        }
    }
    
    // MARK: - Methods
    
    private func setDelegate() {
        inputTextField.delegate = self
    }
    
    private func textFieldPlaceholder(textField: InputContentType) -> String {
        switch textField {
        case .name:
            return "프로젝트 이름을 설정해 주세요."
        case .description:
            return "프로젝트에 대해 간단히 소개해 주세요."
        case .role:
            return "역할을 입력해 주세요. (ex. iOS 개발자)"
        case .nickname:
            return "닉네임을 입력해 주세요."
        }
    }
    
    private func setInputContent(type: InputContentType) {
        switch type {
        case .name:
            titleLabel.text = "프로젝트 이름"
            countLabel.text = "0/10"
        case .description:
            titleLabel.text = "프로젝트 한줄소개"
            countLabel.text = "0/50"
        case .role:
            titleLabel.text = "내 역할"
            countLabel.text = "0/20"
        case .nickname:
            titleLabel.text = "닉네임"
            countLabel.text = "0/50"
        }
        inputTextField.placeholder = textFieldPlaceholder(textField: type)
    }
    
    private func textFieldBorderSetting(textField: UITextField) {
        
        textField.layer.borderColor = UIColor.blue200.cgColor
        textField.layer.borderWidth = 2
        textField.placeholder = .none
        textField.font = .fontGuide(.body2_bold_kor)
    }
    
    private func updateCharacterCount() {
        if let text = inputTextField.text {
            let count = text.count
            switch activeTextField {
            case .name:
                countLabel.text = "\(count)/10"
            case .description:
                countLabel.text = "\(count)/50"
            case .role:
                countLabel.text = "\(count)/20"
            case .nickname:
                countLabel.text = "\(count)/50"
            default:
                countLabel.text = ""
            }
        }
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func removeTextButtonDidTap() {
        inputTextField.text?.removeAll()
    }
}

extension InputContentView: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textFieldBorderSetting(textField: textField)
//        updateCharacterCount()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.layer.borderColor = .none
        textField.layer.borderWidth = 0
        if ((textField.text?.isEmpty) != nil) {
            textField.placeholder = textFieldPlaceholder(textField: activeTextField ?? .name)
        }
//        updateCharacterCount()
        removeTextButton.isHidden = true
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        removeTextButton.isHidden = textField.text?.isEmpty ?? true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        updateCharacterCount()
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: stringRange, with: string)
//        let newLength = text.count + string.count - range.length
        let text = changedText.count
        switch activeTextField {
        case .name:
            if (text <= 10) {
                countLabel.text = "\(changedText.count)/10"
                return text <= 10
            }
        case .description:
            if (text <= 50) {
                countLabel.text = "\(changedText.count)/50"
                return text <= 50
            }
        case .role:
            if (text <= 20) {
                countLabel.text = "\(changedText.count)/20"
                return text <= 20
            }
        case .nickname:
            if (text <= 50) {
                countLabel.text = "\(changedText.count)/50"
                return text <= 50
            }
        default:
            return changedText.count <= 0
        }
        return false
    }
}
