//
//  OnBoardingView.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/19.
//

import UIKit

import SnapKit
import Then
import AuthenticationServices

class OnBoardingView: UIView {
    
    weak var delegate: TappedDelegate?
    
    // MARK: - UI Components
    
    private let puzzlingImageView = UIImageView()
    private let logoImageView = UIImageView()
    private let descriptionLabel = UILabel()
    private let appleLoginButton = ASAuthorizationAppleIDButton()
    private let kakaoLoginButton = UIButton()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OnBoardingView {

    private func setUI(){
        
        self.backgroundColor = .white000

        puzzlingImageView.do {
            $0.image = Image.puzzlingTitle
        }
        
        logoImageView.do {
            $0.image = Image.invitationCodeLogo
        }
        
        descriptionLabel.do {
            $0.text = "꾸준한 회고를 통해\n나만의 퍼즐을 완성하고\n팀과 함께 성장해보세요!"
            $0.font = .fontGuide(.heading3_kor)
            $0.textColor = .gray500
            $0.numberOfLines = 3
            $0.lineHeightMultiple(spacing: 1.25)
        }
        
        appleLoginButton.do {
            $0.cornerRadius = 4
        }
        
        kakaoLoginButton.do {
            $0.setImage(Image.kakaoLogin, for: .normal)
            $0.imageView?.contentMode = .scaleAspectFill
        }
    }


    // MARK: - Layout Helper

    private func setLayout() {
        
        addSubviews(puzzlingImageView, logoImageView, descriptionLabel, appleLoginButton, kakaoLoginButton)
        
        puzzlingImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(76)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(85)
        }
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(puzzlingImageView.snp.bottom).offset(110)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(120)
            $0.height.equalTo(148)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(56)
            $0.centerX.equalToSuperview()
        }
        
        appleLoginButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(84)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
        
        kakaoLoginButton.snp.makeConstraints {
            $0.top.equalTo(appleLoginButton.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
        
    }

    // MARK: - Methods

    private func setAddTarget() {
        kakaoLoginButton.addTarget(self, action: #selector(kakaoLoginButtonTapped), for: .touchUpInside)
    }
    
    func buttonAction() {
            delegate?.tapAction()
        }
    
    // MARK: - @objc Methods
    @objc func kakaoLoginButtonTapped() {
        buttonAction()
    }
}
