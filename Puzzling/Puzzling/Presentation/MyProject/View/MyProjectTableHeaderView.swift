//
//  MyProjectTableHeaderView.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/14.
//

import UIKit

import SnapKit
import Then

final class MyProjectTableHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - UI Components
    
    private let nicknameLabel = UILabel()
    
    // MARK: - Properties
    
    private let nickname: String = UserDefaults.standard.string(forKey: "name") ?? "공듀"
    
    // MARK: - Initializer
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setLayout()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyProjectTableHeaderView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        nicknameLabel.do {
            $0.text = "\(nickname)님 안녕하세요:)"
            $0.textColor = .black000
            $0.font = .fontGuide(.heading2_kor)
        }
    }
    
    // MARK: - View Life Cycle
    
    private func setLayout() {
        contentView.addSubview(nicknameLabel)
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(24)
        }
    }
}
