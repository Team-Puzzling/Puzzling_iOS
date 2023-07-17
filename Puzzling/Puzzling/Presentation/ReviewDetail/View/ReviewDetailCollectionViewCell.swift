//
//  ReviewDetailCollectionViewCell.swift
//  Puzzling
//
//  Created by Kim Min Joo on 2023/07/16.
//


import UIKit

import SnapKit
import Then

final class ReviewDetailCollectionViewCell: UICollectionViewCell {
    
    static var isFromNib: Bool = false
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let divisionLabel = UILabel()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension ReviewDetailCollectionViewCell {
    
    private func setUI() {
        titleLabel.do {
            $0.font = .fontGuide(.body1_bold_kor)
            $0.textColor = .black000
        }
        
        descriptionLabel.do {
            $0.font = .fontGuide(.body2_regular_kor)
            $0.textColor = .gray500
            $0.numberOfLines = 0
            $0.lineBreakMode = .byCharWrapping
        }
        
        divisionLabel.do {
            $0.backgroundColor = .gray300
        }
    }
    
    private func setLayout() {
        contentView.addSubviews(titleLabel, descriptionLabel, divisionLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.horizontalEdges.equalToSuperview().inset(32)
            $0.height.equalTo(24)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(32)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        divisionLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(32)
            $0.height.equalTo(0.5)
        }
    }
}

extension ReviewDetailCollectionViewCell {
    
    func setDataBind(title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
    }
    
    func divisionHidden() {
        divisionLabel.isHidden = true
    }
}
