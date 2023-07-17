//
//  CustomAlert.swift
//  Puzzling
//
//  Created by 천성우 on 2023/07/15.
//

import UIKit

import Then
import SnapKit

enum CustomAlertType {
    case createRetrospect
    case createProject
}


class CustomAlert: UIView {
    
    // MARK: - Properties
    
    private let alertType: CustomAlertType

    
    // MARK: - UI Components
    
    private let containerView = UIView()
    private let contentView = UIView()
    private let logoImage = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let firstButton = UIButton()
    private let secondButton = UIButton()
    private let thirdButton = UIButton() // 프로젝트 등록 뷰에서 사용할 UI Components (닫기 버튼으로 사용)
    
    
    // MARK: - Initializer
    
    init(frame: CGRect, alertType: CustomAlertType) {
        self.alertType = alertType
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
        
        self.backgroundColor = .background500.withAlphaComponent(0.3)
        
        switch alertType {
        case .createRetrospect:
            containerView.do {
                $0.backgroundColor = .clear
            }
            
            contentView.do {
                $0.backgroundColor = .white000
                $0.layer.cornerRadius = 16
            }
            
            logoImage.do {
                $0.image = Image.elementPuzzle
            }
            
            titleLabel.do {
                $0.text = "회고를 저장할까요?"
                $0.font = .fontGuide(.heading4_kor)
                $0.textColor = .black000
            }
            
            subtitleLabel.do {
                $0.text = "수정이 어려우니\n신중하게 작성해 주세요!"
                $0.numberOfLines = 2
                $0.font = .fontGuide(.body3_regular_kor)
                $0.textColor = .gray600
                $0.textAlignment = .center
            }
            
            firstButton.do {
                $0.setTitle("저장하기", for: .normal)
                $0.setTitleColor(UIColor.white000, for: .normal)
                $0.titleLabel?.font = .fontGuide(.body1_bold_kor)
                $0.backgroundColor = .blue400
                $0.layer.cornerRadius = 16
            }
            
            secondButton.do {
                $0.setTitle("취소", for: .normal)
                $0.setTitleColor(UIColor.gray700, for: .normal)
                $0.titleLabel?.font = .fontGuide(.body1_bold_kor)
                $0.backgroundColor = .background050
                $0.layer.cornerRadius = 16
            }
        case .createProject: break
            // 프로젝트 등록 뷰에서 사용하는 Alert setUI 코드 작성
        }
       
    }
    
    
    // MARK: - Layout Helper

    private func setLayout() {
        
        switch alertType {
        case .createRetrospect:
            
            addSubviews(containerView)
            containerView.addSubviews(contentView, logoImage, titleLabel,
                                      subtitleLabel, firstButton, secondButton)
            
            containerView.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(42)
                $0.trailing.equalToSuperview().inset(43)
                $0.centerY.equalToSuperview()
                $0.height.equalTo(340)
            }
            
            contentView.snp.makeConstraints {
                $0.top.equalTo(containerView.snp.top).inset(32)
                $0.bottom.equalTo(containerView.snp.bottom)
                $0.leading.trailing.equalToSuperview()
            }

            logoImage.snp.makeConstraints {
                $0.top.equalTo(containerView.snp.top)
                $0.centerX.equalTo(containerView)
                $0.width.equalTo(78)
                $0.height.equalTo(77)
            }
            
            titleLabel.snp.makeConstraints {
                $0.top.equalTo(contentView.snp.top).inset(70)
                $0.centerX.equalTo(containerView)
            }

            subtitleLabel.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).inset(-8)
                $0.centerX.equalTo(containerView)
            }

            firstButton.snp.makeConstraints {
                $0.top.equalTo(subtitleLabel.snp.bottom).inset(-30)
                $0.leading.trailing.equalToSuperview().inset(24)
                $0.height.equalTo(50)
            }

            secondButton.snp.makeConstraints {
                $0.top.equalTo(firstButton.snp.bottom).inset(-8)
                $0.leading.trailing.equalToSuperview().inset(24)
                $0.height.equalTo(50)
            }
        case .createProject: break
            // 프로젝트 등록 뷰에서 사용하는 Alert setLayout 코드 작성
        }
        
        
    }
    
    // MARK: - Methods

    private func setAddTarget() {
        switch alertType {
        case .createRetrospect:
            secondButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        case .createProject: break
            // 프로젝트 등록 뷰에서 사용하는 Alert setAddTarget 코드 작성
        }
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func cancelButtonTapped() {
        removeFromSuperview()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let navigationController = windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController as? UINavigationController {
            navigationController.navigationBar.isUserInteractionEnabled = true
        }
    }
}
