//
//  ProjectCycleCollectionViewCell.swift
//  Puzzling
//
//  Created by KJ on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class ProjectCycleCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    private let dayLabel = UILabel()
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProjectCycleCollectionViewCell {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        backgroundColor = .background050
        
        makeCornerRadius(ratio: 16)
        
        dayLabel.do {
            $0.font = .fontGuide(.detail2_bold_kor)
            $0.textColor = .black000
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        addSubviews(dayLabel)
        
        dayLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    func setDataBind(model: ProjectCycleModel) {
        dayLabel.text = model.dayOfWeek
    }
}
