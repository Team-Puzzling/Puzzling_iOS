//
//  ProjectNameTableViewCell.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/14.
//

import UIKit

import SnapKit
import Then

final class ProjectNameTableViewCell: UITableViewCell {
    
    private let nameLabel = UILabel()
    private let divisionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setUI() {
        
        separatorInset.left = 0
        selectionStyle = .none
        
        nameLabel.do {
            $0.font = .fontGuide(.body1_bold_kor)
            $0.textColor = .black
        }
        
        divisionLabel.do {
            $0.backgroundColor = .gray200
        }
    }
    
    private func setLayout() {
        
        contentView.addSubviews(nameLabel, divisionLabel)
        
        nameLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(18)
            $0.leading.equalToSuperview().inset(16)
        }
        
        divisionLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
    }
}

extension ProjectNameTableViewCell {
    func setDataBind(name: String) {
        nameLabel.text = name
    }
}
