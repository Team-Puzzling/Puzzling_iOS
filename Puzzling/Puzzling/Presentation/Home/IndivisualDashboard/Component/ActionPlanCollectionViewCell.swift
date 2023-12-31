//
//  ActionPlanCollectionViewCell.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class ActionPlanCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    private let actionTextView = UITextView()
    private let dateLabel = UILabel()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text = nil
        dateLabel.textColor = .gray300
        actionTextView.text = nil
        actionTextView.textColor = .gray600
        self.backgroundColor = .gray100
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ActionPlanCollectionViewCell {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        self.backgroundColor = .gray100
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
        
        actionTextView.do {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 6.5
            let attributes = [NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.foregroundColor: UIColor.gray600, NSAttributedString.Key.font: UIFont.fontGuide(.body3_regular_kor)]
            
            $0.textContainerInset = UIEdgeInsets(top: 12, left: 8, bottom: 20, right: 8)
            $0.isEditable = false
            $0.isScrollEnabled = false
            $0.backgroundColor = .clear
            $0.textContainer.maximumNumberOfLines = 4
            $0.typingAttributes = attributes
        }
        
        dateLabel.do {
            $0.font = .fontGuide(.detail1_regular_kor)
            $0.textColor = .gray300
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        self.addSubviews(actionTextView, dateLabel)
        
        actionTextView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
        }
        
        dateLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview().inset(12)
        }
    }
}

extension ActionPlanCollectionViewCell {
    
    // MARK: - Methods
    
    func setDataBind(dateString: String, content: String) {
        let dateConverted = dateString.convertDateToKoreanDateFormat()
        dateLabel.text = dateConverted
        actionTextView.text = content
    }
    
    func setCellWhenEmpty() {
        actionTextView.text = "아직 회고가 없어요.\n첫 번째 회고를 작성해 보세요!"
        actionTextView.textColor = .gray400
    }
}
