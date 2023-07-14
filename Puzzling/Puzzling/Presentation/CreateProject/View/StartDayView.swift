//
//  StartDayView.swift
//  Puzzling
//
//  Created by KJ on 2023/07/12.
//

import UIKit

import SnapKit
import Then

protocol ProjectStartProtocol: AnyObject {
    func presentToStartTimeVC()
}

final class StartDayView: UIView {
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel()
    private let startDayView = UIView()
    private let startDayLabel = UILabel()
    private let chevronDownButton = UIButton()
    
    // MARK: - Properties
    
    weak var projectStartDelegate: ProjectStartProtocol?
    
    // MARK: - View Life Cycle
    
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

extension StartDayView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        backgroundColor = .clear
        
        titleLabel.do {
            $0.text = "프로젝트 시작날짜"
            $0.font = .fontGuide(.body1_bold_kor)
            $0.textColor = .black000
        }
        
        startDayView.do {
            $0.backgroundColor = .background050
            $0.makeCornerRadius(ratio: 16)
        }
        
        startDayLabel.do {
            $0.text = "0000/00/00"
            $0.font = .fontGuide(.body1_regular_kor)
            $0.textColor = .gray400
        }
        
        chevronDownButton.do {
            $0.setImage(Image.chevronDown, for: .normal)
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        startDayView.addSubviews(startDayLabel, chevronDownButton)
        addSubviews(titleLabel, startDayView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(13)
            $0.leading.equalToSuperview().inset(8)
        }
        
        startDayView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.width.equalTo(188)
            $0.height.equalTo(50)
        }
        
        startDayLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
        
        chevronDownButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(8)
        }
    }
    
    // MARK: - Methods
    
    private func setAddTarget() {
        chevronDownButton.addTarget(self, action: #selector(chevronDownButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func chevronDownButtonDidTap() {
        print("눌림")
        projectStartDelegate?.presentToStartTimeVC()
    }
}
