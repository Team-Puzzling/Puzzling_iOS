//
//  PopUpDayView.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/19.
//

import UIKit

final class PopUpDayView: UIView {
    
    // MARK: - UI Components
    
    private let projectTitleLabel = UILabel()
    private let daysLabel = UILabel()
    private let commentLabel = UILabel()
    
    // MARK: - Properties
    
    private var projectTitle: String!
    private var daysString: String!

    // MARK: - Initializer
    
    init(frame: CGRect, projectTitle: String, daysString: String) {
        self.projectTitle = projectTitle
        self.daysString = daysString
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PopUpDayView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        self.backgroundColor = .white000
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 1, height: -1)
        self.layer.shadowColor = UIColor.black000.cgColor
        self.layer.masksToBounds = false
        
        projectTitleLabel.do {
            $0.font = .fontGuide(.heading4_kor)
            $0.textColor = .black000
            $0.text = projectTitle
        }
        
        daysLabel.do {
            $0.font = .fontGuide(.body3_bold_kor)
            $0.textColor = .blue400
            $0.text = daysString
        }
        
        commentLabel.do {
            $0.font = .fontGuide(.body3_regular_kor)
            $0.textColor = .black000
            $0.text = "매주\n회고를 작성해주세요!"
            $0.numberOfLines = 2
            $0.textAlignment = .left
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        self.addSubviews(projectTitleLabel, commentLabel, daysLabel)
        
        projectTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(24)
        }
        
        commentLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(projectTitleLabel.snp.bottom).offset(8)
        }
        
        daysLabel.snp.makeConstraints {
            $0.top.equalTo(commentLabel.snp.top)
            $0.leading.equalToSuperview().inset(48)
        }
    }
}
