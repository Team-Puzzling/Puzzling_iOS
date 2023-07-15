//
//  ReviewDetailEmptyView.swift
//  Puzzling
//
//  Created by Kim Min Joo on 2023/07/15.
//

import UIKit

import SnapKit
import Then

final class ReviewDetailEmptyView: UIView {
    
    private let puzzleImageView = UIImageView()
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        self.backgroundColor = .systemPink
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ReviewDetailEmptyView {
    private func setUI() {
        puzzleImageView.do {
            $0.image = Image.puzzle_element
        }
        
        label.do {
            $0.text = "작성한 회고가 없어요"
            $0.font = .fontGuide(.heading4_kor)
        }
    }
    
    private func setLayout() {
        
        self.addSubviews(puzzleImageView, label)
        
        puzzleImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(150)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(100)
        }
        
        label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(puzzleImageView.snp.bottom).offset(30)
        }
    }
}
