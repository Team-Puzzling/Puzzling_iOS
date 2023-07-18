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

    // MARK: - Properties
    

    // MARK: - UI Components

    private let titleImage = UIImageView()
    private let newProjectLogo = UIImageView()
    private let newProjectTitle = UILabel()
    private let newProjectButton = UIButton()
    private let wall = UIView()
    private let jointLogo = UIImageView()
    private let joinTitle = UILabel()
    private let joinButton = UIButton()
    
    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
 
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
//            $0.setImage(Image.chevronBack, for: .normal)
//            $0.tintColor = .blue400
//            var config = UIButton.Configuration.plain()
//            config.imagePlacement = NSDirectionalRectEdge.trailing
//
//            newProjectButton.configuration = config
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
//            $0.setImage(Image.chevronBack, for: .normal)
//            $0.tintColor = .blue400
//            var config = UIButton.Configuration.plain()
//            config.imagePlacement = NSDirectionalRectEdge.trailing
//
//            newProjectButton.configuration = config
        }
    }


    // MARK: - Layout Helper

    private func setLayout() {
        
        addSubviews(titleImage, newProjectLogo, newProjectTitle,
                    newProjectButton, wall, jointLogo,
                    joinTitle, joinButton)

        titleImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(76)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(85)
        }
        
        newProjectLogo.snp.makeConstraints {
            $0.top.equalTo(titleImage.snp.bottom).inset(-44)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(150)
            $0.height.equalTo(150)
        }
        
        newProjectTitle.snp.makeConstraints {
            $0.top.equalTo(newProjectLogo.snp.bottom).inset(-16)
            $0.width.equalTo(205)
            $0.centerX.equalToSuperview()
        }
        
        newProjectButton.snp.makeConstraints {
            $0.top.equalTo(newProjectTitle.snp.bottom).inset(-11)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(145)
        }
        
        wall.snp.makeConstraints {
            $0.top.equalTo(newProjectButton.snp.bottom).inset(-36)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(1)
        }
        
        jointLogo.snp.makeConstraints {
            $0.top.equalTo(wall.snp.bottom).inset(-50)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(150)
            $0.height.equalTo(150)
        }
        
        joinTitle.snp.makeConstraints {
            $0.top.equalTo(jointLogo.snp.bottom).inset(-16)
            $0.centerX.equalToSuperview()

        }
        
        joinButton.snp.makeConstraints {
            $0.top.equalTo(joinTitle.snp.bottom).inset(-11)
            $0.centerX.equalToSuperview()
        }
    }

    // MARK: - Methods

    private func setAddTarget() {}

    // MARK: - @objc Methods

}
