//
//  IndivisualMainView.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class IndivisualMainBoxView: UIView {
    
    private let userNameLabel = UILabel()
    private let pieceCountLabel = UILabel()
    private let baseCountLabel = UILabel()
    private let ToBeCollectionView = UIView()
    private let cardView = IndivisualCardButtonView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDelegate()
        setUI()
        setLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
 
extension IndivisualMainBoxView {
    
    private func setDelegate() {
        
    }
    
    private func setUI() {
        self.backgroundColor = .blue50
    }
    
    private func setLayout() {
        
    }
}

extension IndivisualMainBoxView {
    
}

