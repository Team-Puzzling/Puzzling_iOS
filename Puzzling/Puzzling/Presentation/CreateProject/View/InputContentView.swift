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
    
    // MARK: - Initializer
    
    init(type: InputContentType) {
        super.init(frame: .zero)
        setUI()
        setLayout()
        setInputContent(type: type)
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
    
    private func setInputContent(type: InputContentType) {
        
        switch type {
        case .name:
            titleLabel.text = "프로젝트 이름"
            inputTextField.placeholder = "프로젝트 이름을 설정해 주세요."
            countLabel.text = "0/10"
        case .description:
            titleLabel.text = "프로젝트 한줄소개"
            inputTextField.placeholder = "프로젝트에 대해 간단히 소개해 주세요."
            countLabel.text = "0/10"
        case .role:
            titleLabel.text = "내 역할"
            inputTextField.placeholder = "프로젝트 이름을 설정해 주세요."
            countLabel.text = "0/10"
        case .nickname:
            titleLabel.text = "닉네임"
            inputTextField.placeholder = "닉네임을 입력해 주세요."
            countLabel.text = "0/10"
        }
    }
    
    private func textFieldBorderSetting(textField: UITextField) {
        
        textField.layer.borderColor = UIColor.blue200.cgColor
        textField.layer.borderWidth = 2
        textField.placeholder = .none
        textField.font = .fontGuide(.body2_bold_kor)
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
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.layer.borderColor = .none
        textField.layer.borderWidth = 0
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // delegate
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        removeTextButton.isHidden = textField.text?.isEmpty ?? true
    }
}
