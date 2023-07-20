//
//  EnterView.swift
//  Puzzling
//
//  Created by 천성우 on 2023/07/17.
//

import UIKit

import SnapKit
import Then

class EnterProjectView: UIView {

    // MARK: - UI Components

    private let titleImage = UIImageView()
    private let newProjectLogo = UIImageView()
    private let newProjectTitle = UILabel()
    private let newProjectButton = UIButton()
    private let wall = UIView()
    private let jointLogo = UIImageView()
    private let joinTitle = UILabel()
    private let joinButton = UIButton()
    
    // MARK: - Properties
    
    var newProjectButtonHandler: (() -> Void)?
    var joinButtonHandler: (() -> Void)?
    
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
        
        newProjectLogo.do {
            $0.image = Image.newPuzzle
        }
        
        newProjectTitle.do {
            $0.text = "프로젝트를 새로 등록할까요?"
            $0.textColor = .black000
            $0.font = UIFont.boldSystemFont(ofSize: 18)
        }
        
        
        newProjectButton.do {
            $0.setTitle("프로젝트 등록하기 >", for: .normal)
            $0.setTitleColor(UIColor.blue400, for: .normal)
            $0.titleLabel?.font = .fontGuide(.body1_bold_kor)
        }
        
        wall.do {
            $0.backgroundColor = .gray300
        }
        
        jointLogo.do {
            $0.image = Image.joinPuzzle
        }
        
        joinTitle.do {
            $0.text = "초대코드가 있으신가요?"
            $0.textColor = .black000
            $0.font = UIFont.boldSystemFont(ofSize: 18)
        }
        
        joinButton.do {
            $0.setTitle("프로젝트 참여하기 >", for: .normal)
            $0.setTitleColor(UIColor.blue400, for: .normal)
            $0.titleLabel?.font = .fontGuide(.body1_bold_kor)
        }
    }


    // MARK: - Layout Helper

    private func setLayout() {
        
        addSubviews(titleImage, newProjectLogo, newProjectTitle,
                    newProjectButton, wall, jointLogo,
                    joinTitle, joinButton)
        
        titleImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(64)
            $0.centerX.equalToSuperview()
        }
        
        wall.snp.makeConstraints {
            $0.top.equalToSuperview().inset(setScreenHeight() + 20)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(1)
        }
        
        newProjectButton.snp.makeConstraints {
            $0.bottom.equalTo(wall.snp.top).offset(-53)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(145)
            $0.height.equalTo(16)
        }
        
        newProjectTitle.snp.makeConstraints {
            $0.bottom.equalTo(newProjectButton.snp.top).offset(-11)
            $0.centerX.equalToSuperview()
        }
        
        newProjectLogo.snp.makeConstraints {
            $0.bottom.equalTo(newProjectTitle.snp.top).offset(-16)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(150)
        }
        
        jointLogo.snp.makeConstraints {
            $0.top.equalTo(wall.snp.bottom).offset(36)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(150)
        }
        
        joinTitle.snp.makeConstraints {
            $0.top.equalTo(jointLogo.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        joinButton.snp.makeConstraints {
            $0.top.equalTo(joinTitle.snp.bottom).offset(11)
            $0.centerX.equalToSuperview()
        }
    }

    // MARK: - Methods

    private func setAddTarget() {
        newProjectButton.addTarget(self, action: #selector(newProjectButtonDidTap), for: .touchUpInside)
        joinButton.addTarget(self, action: #selector(joinButtonDidTap), for: .touchUpInside)
    }
    
    private func setScreenHeight() -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        return screenHeight / 2
    }

    // MARK: - @objc Methods
    
    @objc
    private func newProjectButtonDidTap() {
        newProjectButtonHandler?()
    }
    
    @objc
    private func joinButtonDidTap() {
        joinButtonHandler?()
    }
}
