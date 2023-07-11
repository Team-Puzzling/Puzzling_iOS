//
//  BottomSheetView.swift
//  Puzzling
//
//  Created by 천성우 on 2023/07/11.
//

import UIKit

import Then
import SnapKit

class BottomSheetView: UIView {
    
    // MARK: - Properties
    
    private let optionTILButton = CustomRadioButton(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
    private let optionFiveFButton = CustomRadioButton(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
    private let optionAARButton = CustomRadioButton(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
    
    private let optionTILTitle = UILabel().then{
        $0.text = "TIL"
        $0.textColor = .gray700
        $0.font = .fontGuide(.body1_bold_eng)
    }
    
    private let optionFiveFTitle = UILabel().then{
        $0.text = "5F"
        $0.textColor = .gray700
        $0.font = .fontGuide(.body1_bold_eng)
    }
    
    private let optionAARTitle = UILabel().then{
        $0.text = "AAR"
        $0.textColor = .gray700
        $0.font = .fontGuide(.body1_bold_eng)
    }
    
    private let optionTILSubtitle = UILabel().then{
        $0.text = "학습과 자기 반성을 통해 향후 더 나은 결정을 내릴 \n수 있게 해 주는 회고 방식이에요!"
        $0.numberOfLines = 2
        $0.textColor = .gray600
        $0.font = .fontGuide(.detail1_regular_kor)
    }
    
    private let optionFiveFSubtitle = UILabel().then{
        $0.text = "다양한 측면을 고려하여 개인과 프로젝트 전체적인 \n관점을 보여주는 회고 방식이에요!"
        $0.numberOfLines = 2
        $0.textColor = .gray600
        $0.font = .fontGuide(.detail1_regular_kor)
    }
    
    private let optionAARSubtitle = UILabel().then{
        $0.text = "목표 달성에 대한 책임감과 함께, 개선에 중점을 두\n는 회고 방식이에요!"
        $0.numberOfLines = 2
        $0.textColor = .gray600
        $0.font = .fontGuide(.detail1_regular_kor)
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    
    private func setLayout() {
        
        addSubviews(
            optionTILButton,
            optionTILTitle,
            optionTILSubtitle,
            optionFiveFButton,
            optionFiveFTitle,
            optionFiveFSubtitle,
            optionAARButton,
            optionAARTitle,
            optionAARSubtitle
        )
        
        optionTILButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(57)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(16)
            $0.height.equalTo(16)
        }
        
        optionTILTitle.snp.makeConstraints {
            $0.top.equalTo(optionTILButton.snp.top)
            $0.leading.equalTo(optionTILButton.snp.trailing).inset(-20)
        }
        
        optionTILSubtitle.snp.makeConstraints {
            $0.top.equalTo(optionTILTitle.snp.top)
            $0.leading.equalTo(optionTILTitle.snp.trailing).inset(-30)
        }
        
        optionFiveFButton.snp.makeConstraints {
            $0.top.equalTo(optionTILButton.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(16)
            $0.height.equalTo(16)
        }
        
        optionFiveFTitle.snp.makeConstraints {
            $0.top.equalTo(optionFiveFButton.snp.top)
            $0.leading.equalTo(optionFiveFButton.snp.trailing).inset(-20)
        }
        
        optionFiveFSubtitle.snp.makeConstraints {
            $0.top.equalTo(optionFiveFTitle.snp.top)
            $0.leading.equalTo(optionFiveFTitle.snp.trailing).inset(-36)
        }
        
        optionAARButton.snp.makeConstraints {
            $0.top.equalTo(optionFiveFButton.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(16)
            $0.height.equalTo(16)
        }
        
        optionAARTitle.snp.makeConstraints {
            $0.top.equalTo(optionAARButton.snp.top)
            $0.leading.equalTo(optionAARButton.snp.trailing).inset(-20)
        }
        
        optionAARSubtitle.snp.makeConstraints {
            $0.top.equalTo(optionAARTitle.snp.top)
            $0.leading.equalTo(optionAARTitle.snp.trailing).inset(-22)
        }
    }
}


