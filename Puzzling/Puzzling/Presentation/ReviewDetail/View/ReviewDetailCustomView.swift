//
//  ReviewDetailCustomView.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/17.
//

import UIKit

import SnapKit
import Then

extension ReviewDetailCustomView {
    @frozen
    enum reviewTemplate: CaseIterable {
        case firstTemplate, secondTemplate, thirdTemplate
        
        var viewCount: Int {
            switch self {
            case .firstTemplate:
                return 3
            case .secondTemplate:
                return 3
            case .thirdTemplate:
                return 5
            }
        }
    }
}

final class ReviewDetailCustomView: UIView {

    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
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

extension ReviewDetailCustomView {
    
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
    }
    
    private func setLayout() {
        self.addSubviews(titleLabel, descriptionLabel)
        titleLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(24)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview().inset(16)
        }
    }
}

extension ReviewDetailCustomView {
    
    func setDataBind(title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
//        sendLabelHeight()
    }
    
//    func sendLabelHeight() {
//        let labelHeight = descriptionLabel.textHeight(withWidth: UIScreen.main.bounds.width)
//        print(labelHeight)
//        print(descriptionLabel.textHeight(withWidth: UIScreen.main.bounds.width), "pppppp")
//        NotificationCenter.default.post(name: NSNotification.Name("LabelHeightNotification"), object: labelHeight)
//    }
    
}

//extension UILabel {
//    func textHeight(withWidth width: CGFloat) -> CGFloat {
//       guard let text = text else {
//          return 0
//       }
//        return text.height(withWidth: UIScreen.main.bounds.width, font: UIFont.fontGuide(.body2_regular_kor))
//    }
//}

extension String {
    
    func textHeight(withWidth width: CGFloat) -> CGFloat {
        let text = self
         return text.height(withWidth:width, font: UIFont.fontGuide(.body2_regular_kor))
     }
    
    func height(withWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
}
