//
//  MyProjectTableHeaderView.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/13.
//

import UIKit

import SnapKit
import Then

final class MyProjectTableHeaderView: UITableViewHeaderFooterView {
    
    private let nickname: String = "공듀"
    private let nicknameLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setLayout()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        nicknameLabel.do {
            $0.text = "\(nickname)님 안녕하세요:)"
            $0.textColor = .black000
            $0.font = .fontGuide(.heading2_kor)
        }
    }
    
    private func setLayout() {
        contentView.addSubview(nicknameLabel)
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.leading.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(24)
        }
    }
}
