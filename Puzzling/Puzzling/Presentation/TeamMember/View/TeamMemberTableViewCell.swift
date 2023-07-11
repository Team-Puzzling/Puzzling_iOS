//
//  TeamMemberTableViewCell.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/11.
//


import UIKit

import SnapKit
import Then

final class TeamMemberTableViewCell: UITableViewCell {
    
    static let identifier = "TeamMemberTableViewCell"
    
    private lazy var nicknameLabel = UILabel()
    private lazy var partLabel = UILabel()
    private let horizontalStackView = UIStackView()
    public let divisionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUI() {
        
        separatorInset.left = 0
        
        selectionStyle = .none
        backgroundColor = .white000
        
        nicknameLabel.do {
            $0.font = .systemFont(ofSize: 14)
            $0.textColor = .black
        }
        
        partLabel.do {
            $0.font = .systemFont(ofSize: 14)
            $0.textColor = .black
        }
        
        divisionLabel.do {
            $0.backgroundColor = Color.gray3
        }

    }
    
    func setLayout() {
        
        contentView.addSubviews(nicknameLabel, partLabel, divisionLabel)
        nicknameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().dividedBy(2)
            $0.top.equalToSuperview()
            $0.height.equalTo(30)
        }
        
        partLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().dividedBy(2)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview()
            $0.height.equalTo(30)
        }
        
        divisionLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    func configureCell(_ data: TeamMemberDataModel) {
        
        nicknameLabel.text = data.reviewWriters?[0].memberNickname
        partLabel.text = data.reviewWriters?[0].memberRole
    }
}

extension UITableViewCell{
    
    static var cellIdentifier : String {
        return String(describing: self)
    }
}

