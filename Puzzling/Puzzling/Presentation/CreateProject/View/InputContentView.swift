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
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
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
            $0.makeCornerRadius(ratio: 16)
        }
        
        countLabel.do {
            $0.font = .fontGuide(.detail1_regular_kor)
            $0.textColor = .gray400
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
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
        
        countLabel.snp.makeConstraints {
            $0.top.equalTo(inputTextField.snp.bottom).offset(5)
            $0.trailing.equalToSuperview().inset(8)
        }
    }
    
    // MARK: - Methods
    
    // MARK: - @objc Methods
}
