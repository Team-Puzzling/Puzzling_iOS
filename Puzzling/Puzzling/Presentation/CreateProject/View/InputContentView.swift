//
//  InputContentView.swift
//  Puzzling
//
//  Created by KJ on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class InputContentView: UIView {
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel()
    private let inputTextField = UITextField()
    private let countLabel = UILabel()
    private let textFieldButtonView = UIView()
    private let textFieldButton = UIButton()
    private let textFieldWarningView = UIView()
    private let warningImageView = UIImageView()
    private let warningLabel = UILabel()
    
    // MARK: - Properties
    
    var activeTextField: InputContentType?
    
    // MARK: - Initializer
    
    init(type: InputContentType) {
        super.init(frame: .zero)
        setUI()
        setLayout()
        setDelegate()
        setInputContent(type: type)
        setAddTarget()
        activeTextField = type
        setTapScreen()
        setNotification()
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
        
        textFieldButton.do {
            $0.setImage(Image.textFieldXMark, for: .normal)
            $0.isHidden = true
        }
        
        warningImageView.do {
            $0.image = Image.warning
            $0.isHidden = true
        }
        
        warningLabel.do {
//            $0.text = "특수문자, 이모지를 사용할 수 없어요."
            $0.font = .fontGuide(.detail1_regular_kor)
            $0.textColor = .red400
            $0.isHidden = true
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        textFieldButtonView.addSubview(textFieldButton)
        addSubviews(titleLabel, inputTextField, countLabel, warningLabel)
        
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
        
        textFieldButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(22)
        }
        
        countLabel.snp.makeConstraints {
            $0.top.equalTo(inputTextField.snp.bottom).offset(5)
            $0.trailing.equalToSuperview().inset(8)
        }
        
        warningLabel.snp.makeConstraints {
            $0.top.equalTo(countLabel)
            $0.leading.equalToSuperview().inset(8)
        }
    }
    
    // MARK: - Methods
    
    private func setDelegate() {
        inputTextField.delegate = self
    }
    
    private func setAddTarget() {
        textFieldButton.addTarget(self, action: #selector(removeTextButtonDidTap), for: .touchUpInside)
    }
    
    private func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(setTextFieldWarningStatus(_:)), name: Notification.Name("textFieldWarningNotification"), object: nil)
    }
    
    private func textFieldPlaceholder(type: InputContentType) -> String {
        switch type {
        case .name:
            return "프로젝트 이름을 설정해 주세요."
        case .description:
            return "프로젝트에 대해 간단히 소개해 주세요."
        case .role:
            return "역할을 입력해 주세요. (ex. iOS 개발자)"
        case .nickname:
            return "닉네임을 입력해 주세요."
        case .invitationCode:
            return "초대코드를 입력해 주세요."
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
            countLabel.text = "0/10"
        case .invitationCode:
            titleLabel.text = "초대코드"
            countLabel.text = "0/13"
        }
        inputTextField.placeholder = textFieldPlaceholder(type: type)
    }
    
    private func activeTextFieldBorderSetting(textField: UITextField) {
        textField.layer.borderColor = UIColor.blue200.cgColor
        textField.layer.borderWidth = 2
        textField.placeholder = .none
        textField.font = .fontGuide(.body2_bold_kor)
        textFieldButton.setImage(Image.textFieldXMark, for: .normal)
        textFieldButton.isEnabled = true
        warningLabel.isHidden = true
    }
    
    private func warningTextField(textField: UITextField, type: WarningMessage) {
        switch type {
        case .emoji:
            warningLabel.text = "특수문자, 이모지를 사용할 수 없어요."
            warningTextFieldBorderSetting(textField: textField)
        case .invitationCode:
            warningLabel.text = "유효하지 않은 초대코드에요. 코드를 확인해 주세요."
            if activeTextField == .invitationCode {
                warningTextFieldBorderSetting(textField: textField)
            }
        case .duplicateNickname:
            warningLabel.text = "이미 사용 중인 닉네임이에요."
            if activeTextField == .nickname {
                warningTextFieldBorderSetting(textField: textField)
            }
        }
    }
    
    private func warningTextFieldBorderSetting(textField: UITextField) {
        textField.layer.borderColor = UIColor.red200.cgColor
        textField.layer.borderWidth = 2
        textFieldButton.isHidden = false
        textFieldButton.setImage(Image.warning, for: .normal)
        textFieldButton.isEnabled = false
        warningLabel.isHidden = false
    }
    
    private func defaultTextFieldBorderSetting(textField: UITextField) {
        textField.layer.borderColor = .none
        textField.layer.borderWidth = 0
        textFieldButton.isHidden = true
        warningLabel.isHidden = true
    }
    
    private func textFieldStatus(textField: UITextField) {
        if let text = textField.text {
            if text.isOnlyKorEng() {
                activeTextFieldBorderSetting(textField: textField)
            } else {
                warningTextField(textField: textField, type: .emoji)
            }
        }
    }
    
    private func textFieldNotification(textField: UITextField, contentType: InputContentType) {
        if let text = textField.text {
            let userInfo = TextFieldInfo(text: text, type: contentType)
            NotificationCenter.default.post(
                name: Notification.Name("textFieldNotification"),
                object: nil,
                userInfo: ["userInfo": userInfo]
            )
        }
    }
    
    private func textFieldInfoNotification(contentType: InputContentType) {
        if let textFieldInfo = activeTextField {
            let userInfo = textFieldInfo
            NotificationCenter.default.post(
                name: Notification.Name("textFieldInfoNotification"),
                object: nil,
                userInfo: ["userInfo": userInfo]
            )
        }
    }
    
    private func setTapScreen() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapScreen))
        tapGestureRecognizer.cancelsTouchesInView = false
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func removeTextButtonDidTap() {
        setInputContent(type: activeTextField ?? .name)
        inputTextField.placeholder = .none
        inputTextField.text?.removeAll()
    }

    @objc
    private func didTapScreen(_ gesture: UITapGestureRecognizer) {
        let touchLocation = gesture.location(in: self)
        if !inputTextField.frame.contains(touchLocation) {
            self.endEditing(true)
        }
    }
    
    @objc
    private func setTextFieldWarningStatus(_ notification: Notification) {
        
        if let type = notification.userInfo?["userInfo"] as? WarningMessage {
            warningTextField(textField: inputTextField, type: type)
        }
    }
}

extension InputContentView: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeTextFieldBorderSetting(textField: textField)
        if let text = textField.text {
            if text.isOnlyKorEng() {
                activeTextFieldBorderSetting(textField: textField)
                textFieldNotification(textField: textField, contentType: activeTextField ?? .name)
            } else {
                warningTextField(textField: textField, type: .emoji)
                textFieldButton.isHidden = false
            }
            textFieldButton.isHidden = !text.isEmpty ? false : true
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            if text.isOnlyKorEng() {
                defaultTextFieldBorderSetting(textField: textField)
                textFieldNotification(textField: textField, contentType: activeTextField ?? .name)
            } else {
                warningTextField(textField: textField, type: .emoji)
                textFieldButton.isHidden = false
            }
            
            if text.isEmpty {
                defaultTextFieldBorderSetting(textField: textField)
                textField.placeholder = textFieldPlaceholder(type: activeTextField ?? .name)
                textField.font = .fontGuide(.body2_regular_kor)
            }
        }
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        textFieldStatus(textField: textField)
        textFieldButton.isHidden = textField.text?.isEmpty ?? true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: stringRange, with: string)
        let textCount = changedText.count
        switch activeTextField {
        case .name:
            if (textCount <= 10) {
                countLabel.text = "\(changedText.count)/10"
                return true
            }
        case .description:
            if (textCount <= 50) {
                countLabel.text = "\(changedText.count)/50"
                return true
            }
        case .role:
            if (textCount <= 20) {
                countLabel.text = "\(changedText.count)/20"
                return true
            }
        case .nickname:
            if (textCount <= 10) {
                countLabel.text = "\(changedText.count)/10"
                return true
            }
        case .invitationCode:
            if (textCount <= 13) {
                countLabel.text = "\(changedText.count)/13"
                return true
            }
        default:
            return false
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            if text.isEmpty {
                defaultTextFieldBorderSetting(textField: textField)
                textField.placeholder = textFieldPlaceholder(type: activeTextField ?? .name)
                textField.font = .fontGuide(.body2_regular_kor)
            } else {
                if text.isOnlyKorean() {
                    textFieldNotification(textField: textField, contentType: activeTextField ?? .name)
                }
            }
        }
        return true
    }
}
