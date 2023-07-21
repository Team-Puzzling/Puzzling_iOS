//
//  MyReviewListCollectionViewCell.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/14.
//

import UIKit

import SnapKit
import Then

final class MyReviewListCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    private let view = UIView()
    let dateLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let chevronRightLabel = UIImageView()
    
    // MARK: - Properties
    
    static var isFromNib: Bool = false
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyReviewListCollectionViewCell {
    
    // MARK: - UI Components Property
    
    private func setUI() {
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
    
    // MARK: - Layout Helper
    
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
}

extension MyReviewListCollectionViewCell {
    
    // MARK: - Methods
    
    func setDataBind(_ reviewListData: ReviewListResponse) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
                
        let convertDate = dateFormatter.date(from: reviewListData.reviewDate)
                
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "yyyy.MM.dd"
        let convertStr = myDateFormatter.string(from: convertDate!)
        
        dateLabel.text = convertStr
        descriptionLabel.text = reviewListData.contents
    }
    
    func getSelectedData() -> String {
        guard let text = dateLabel.text else { return "2023.07.17" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(identifier: "KST")
        guard let yyyymmDate = dateFormatter.date(from: text) else { return "2023-07-17" }
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: yyyymmDate)
    }
}
