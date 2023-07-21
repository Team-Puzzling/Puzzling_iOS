//
//  HomeBottomSheetCellButton.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/19.
//

import UIKit

enum HomeBottomViewButtonType {
    case create
    case join
    
    var title: String {
        switch self {
        case .create:
            return "프로젝트 등록하기"
        case .join:
            return "프로젝트 참여하기"
        }
    }
}

final class HomeBottomSheetCellButton: UIView {
    
    // MARK: - UI Components
    
    private let plusImageView = UIImageView()
    private let titleLabel = UILabel()
    private var buttonTitle: String!
    
    // MARK: - Initializer
    
    init(frame: CGRect, buttonTitle: String) {
        self.buttonTitle = buttonTitle
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeBottomSheetCellButton {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        self.backgroundColor = .white000
        
        plusImageView.do {
            $0.image = Image.plusButtonFill
            $0.contentMode = .scaleAspectFit
        }
        
        titleLabel.do {
            $0.textColor = .gray600
            $0.font = .fontGuide(.body1_bold_kor)
            $0.text = buttonTitle
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        self.addSubviews(plusImageView, titleLabel)
        
        plusImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.size.equalTo(28)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(plusImageView.snp.trailing).offset(16)
        }
    }
}
