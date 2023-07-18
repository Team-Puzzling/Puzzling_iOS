//
//  OnBoardingView.swift
//  Puzzling
//
//  Created by 천성우 on 2023/07/17.
//

import UIKit

import SnapKit
import Then

class OnBoardingView: UIView {

    // MARK: - Properties
    weak var delegate: TappedDelegate?
        

    // MARK: - UI Components

    private let titleImage = UIImageView()
    private let titleLogo = UIImageView()
    private let subtitleLabel = UILabel()
    private let kakaoLogin = UIButton()
    
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

    // MARK: - UI Components Property

    private func setUI(){
        
        self.backgroundColor = .white000

        titleImage.do {
            $0.image = Image.puzzlingTitle
        }
        
        titleLogo.do {
            $0.image = Image.invitationCodeLogo
        }
        
        subtitleLabel.do {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 10  // 원하는 행간격을 설정합니다.
            paragraphStyle.alignment = .center  // 텍스트를 중앙 정렬합니다.
            
            let attributedText = NSAttributedString(string: "꾸준한 회고를 통해\n나만의 퍼즐을 완성하고\n팀과 함께 성장해보세요!",
                                                     attributes: [.font: UIFont.boldSystemFont(ofSize: 20),
                                                                  .foregroundColor: UIColor.gray500,
                                                                  .paragraphStyle: paragraphStyle])
            
            $0.attributedText = attributedText
            $0.numberOfLines = 3
        }


        
        kakaoLogin.do {
            $0.setImage(Image.kakaoLogin, for: .normal)
        }
    }


    // MARK: - Layout Helper

    private func setLayout() {
        
        addSubviews(titleImage, titleLogo, subtitleLabel, kakaoLogin)
        
        titleImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(76)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(85)
        }
        
        titleLogo.snp.makeConstraints {
            $0.top.equalTo(titleImage.snp.bottom).inset(-110)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(120)
            $0.height.equalTo(148)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLogo.snp.bottom).inset(-56)
            $0.centerX.equalToSuperview()
        }
        
        kakaoLogin.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).inset(-84)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(55)
        }
        
    }

    // MARK: - Methods

    private func setAddTarget() {
        kakaoLogin.addTarget(self, action: #selector(kakaoLoginButtonTapped), for: .touchUpInside)
    }
    
    func btnAction() {
            print("SecondViewController btn Action")
            
            // 첫 번째 뷰에서 선언한 함수를 통해 데이터 전달
            delegate?.tapAction(value: "delegate practice")
        }
    
    // MARK: - @objc Methods
    @objc func kakaoLoginButtonTapped() {
        btnAction()
    }
}
