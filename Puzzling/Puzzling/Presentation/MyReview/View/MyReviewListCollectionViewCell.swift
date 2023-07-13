//
//  MyReviewListCollectionViewCell.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/13.
//

import UIKit

final class MyReviewListCollectionViewCell: UICollectionViewCell {
    
    static var isFromNib: Bool = false
    
    // MARK: - UI Components
    
    private let view = UIView()
    private let dateLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let chevronRightLabel = UIImageView()
    
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

extension MyReviewListCollectionViewCell {
    
    func setUI() {
        view.do {
            $0.backgroundColor = .background050
            $0.makeRounded(radius: 16)
        }
        
        dateLabel.do {
            $0.font = .fontGuide(.body1_bold_kor)
            $0.textColor = .black000
        }
        
        descriptionLabel.do {
            $0.font = .fontGuide(.body3_regular_kor)
            $0.textColor = .gray400
        }
        
        chevronRightLabel.do {
            $0.image = Image.chevronRight
        }
    }
    
    private func setLayout() {
        contentView.addSubview(view)
        view.addSubviews(dateLabel, descriptionLabel, chevronRightLabel)
        
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            $0.height.equalTo(24)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(84)
            $0.bottom.equalToSuperview().inset(15)
        }
        
        chevronRightLabel.snp.makeConstraints {
            $0.size.equalTo(36)
            $0.trailing.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
        }
    }
    
    func setDataBind(_ reviewListData: MyReviewListDataModel) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
                
        let convertDate = dateFormatter.date(from: reviewListData.reviewDate) // Date 타입으로 변환
                
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "yyyy.MM.dd" // 2020년 08월 13일 오후 04시 30분
        let convertStr = myDateFormatter.string(from: convertDate!)
        
        dateLabel.text = convertStr
        descriptionLabel.text = reviewListData.contents
        
    }
}
