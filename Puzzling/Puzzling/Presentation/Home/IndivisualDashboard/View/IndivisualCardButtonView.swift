//
//  IndivisualCardView.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class IndivisualCardButtonView: UIView {
    
    // MARK: - UI Components
    
    private let containerView = UIView()
    private let backgroundImageView = UIImageView()
    private let puzzleBoardLabel = UILabel()
    private let puzzleBoardCountLabel = UILabel()
    private let chevronNextImageView = UIImageView()
    
    // MARK: - Properties

    private var puzzleBoardCount: Int = 0 {
        didSet {
            puzzleBoardCountLabel.text = "\(puzzleBoardCount) 판"
        }
    }
    private var cardTitle: String!
    
    // MARK: - Initializer
    
    init(frame: CGRect, cardTitle: String) {
        self.cardTitle = cardTitle
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
 
extension IndivisualCardButtonView {
    
    // MARK: - UI Components Property
        
    private func setUI() {
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowColor = UIColor.blue400.cgColor
        
        containerView.do {
            $0.layer.cornerRadius = 16
            $0.layer.masksToBounds = true
        }
        
        backgroundImageView.do {
            $0.image = Image.indivisualCardBackground
            $0.contentMode = .scaleAspectFill
        }
        
        puzzleBoardLabel.do {
            $0.text = cardTitle
            $0.font = .fontGuide(.heading3_kor)
            $0.textColor = .black000
        }
        
        chevronNextImageView.do {
            let configuration = UIImage.SymbolConfiguration(pointSize: 0, weight: .semibold, scale: .medium)
            $0.image = UIImage(systemName: "chevron.right", withConfiguration: configuration)
            $0.contentMode = .scaleAspectFit
            $0.tintColor = .gray500
        }
        
        puzzleBoardCountLabel.do {
            $0.text = "0 판"
            $0.font = .fontGuide(.heading4_kor)
            $0.textColor = .blue400
            $0.textAlignment = .right
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        self.addSubview(containerView)
        containerView.addSubviews(backgroundImageView, puzzleBoardLabel, chevronNextImageView, puzzleBoardCountLabel)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        puzzleBoardLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
        
        chevronNextImageView.snp.makeConstraints {
            $0.size.equalTo(20)
            $0.trailing.equalToSuperview().inset(22)
            $0.centerY.equalToSuperview()
        }
        
        puzzleBoardCountLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(chevronNextImageView.snp.leading).offset(-20)
            $0.width.lessThanOrEqualTo(50)
        }
    }
}

extension IndivisualCardButtonView {
    
    // MARK: - Methods
    
    func passBoardCount(count: Int) {
        self.puzzleBoardCount = count
    }
}
