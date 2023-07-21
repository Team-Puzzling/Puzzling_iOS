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
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel()
    private let descriptionTextView = UITextView()
    private let divisionLabel = UILabel()
    
    // MARK: - Properties
    
    static var isFromNib: Bool = false
    
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

extension ReviewDetailCollectionViewCell {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        titleLabel.do {
            $0.font = .fontGuide(.body1_bold_kor)
            $0.textColor = .black000
        }
        
        descriptionTextView.do {
            $0.font = .fontGuide(.body2_regular_kor)
            $0.textColor = .gray500
            $0.isEditable = false
            $0.textContainer.lineFragmentPadding = 0
            $0.textContainerInset =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            $0.isScrollEnabled = false
        }
        
        divisionLabel.do {
            $0.backgroundColor = .gray300
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        contentView.addSubviews(titleLabel, descriptionTextView, divisionLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.horizontalEdges.equalToSuperview().inset(32)
            $0.height.equalTo(24)
        }
        
        descriptionTextView.snp.makeConstraints {
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
    
    // MARK: - Methods
    
    func setDataBind(title: String, description: String) {
        titleLabel.text = title
        descriptionTextView.text = description
    }
    
    func divisionHidden() {
        divisionLabel.isHidden = true
    }
}
