//
//  TeamMemberTableViewCell.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/17.
//

import UIKit

import SnapKit
import Then

final class TeamMemberTableViewCell: UITableViewCell {
    
    // MARK: - UI Components
    
    private let nicknameLabel = UILabel()
    private let partLabel = UILabel()
    private let divisionLabel = UILabel()
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension TeamMemberTableViewCell {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        separatorInset.left = 0
        selectionStyle = .none
        
        nicknameLabel.do {
            $0.font = .fontGuide(.body3_bold_kor)
            $0.textColor = .black
        }
        
        partLabel.do {
            $0.font = .fontGuide(.body3_regular_kor)
            $0.textColor = .black
        }
        
        divisionLabel.do {
            $0.backgroundColor = .gray200
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        contentView.addSubviews(nicknameLabel, partLabel, divisionLabel)
        
        nicknameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(32)
            $0.width.equalTo(122)
            $0.top.bottom.equalToSuperview()
        }
        
        partLabel.snp.makeConstraints {
            $0.width.equalTo(122)
            $0.trailing.equalToSuperview().inset(32)
            $0.top.bottom.equalToSuperview()
        }
        
        divisionLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
    }
}

extension TeamMemberTableViewCell {
    
    // MARK: - Methods
    
    func setDataBind(nickname: String, part: String) {
        nicknameLabel.text = nickname
        partLabel.text = part
    }
}
