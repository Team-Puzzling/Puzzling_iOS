//
//  TeamRankTableViewCell.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/15.
//

import UIKit

final class TeamRankTableViewCell: UITableViewCell {

    private let rankNumberLabel = UILabel()
    
    private let userStackView = UIStackView()
    private let userNameLabel = UILabel()
    private let roleLabel = UILabel()
    
    private let piecesStackView = UIStackView()
    private let piecesCountLabel = UILabel()
    private let pieceLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TeamRankTableViewCell {

    private func setUI() {
        self.backgroundColor = .clear
        
        rankNumberLabel.do {
            $0.font = .fontGuide(.body1_bold_kor)
            $0.textColor = .blue400
        }
        
        userStackView.do {
            $0.axis = .horizontal
            $0.spacing = 4
            $0.alignment = .center
        }
        
        userNameLabel.do {
            $0.font = .fontGuide(.body3_bold_kor)
            $0.textColor = .black000
            $0.numberOfLines = 1
        }
        
        roleLabel.do {
            $0.font = .fontGuide(.detail3_regular_kor)
            $0.textColor = .black000
        }
        
        piecesStackView.do {
            $0.axis = .horizontal
            $0.spacing = 4
            $0.alignment = .center
        }
        
        piecesCountLabel.do {
            $0.font = .fontGuide(.body3_bold_kor)
            $0.textColor = .black000
        }
        
        pieceLabel.do {
            $0.text = "조각"
            $0.font = .fontGuide(.detail2_regular_kor)
            $0.textColor = .black000
        }
    }
    
    private func setLayout() {
        self.addSubviews(rankNumberLabel, userStackView, piecesStackView)
        
        userStackView.addArrangedSubviews(userNameLabel, roleLabel)
        piecesStackView.addArrangedSubviews(piecesCountLabel, pieceLabel)
        
        rankNumberLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(32)
            $0.centerY.equalToSuperview()
        }
        
        userStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(54)
            $0.centerY.equalToSuperview()
            $0.width.lessThanOrEqualTo(150)
            $0.height.equalToSuperview()
        }
        
        piecesStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(32)
            $0.centerY.equalToSuperview()
            $0.width.lessThanOrEqualTo(40)
            $0.height.equalToSuperview()
        }
        
        roleLabel.snp.makeConstraints {
            $0.bottom.equalTo(userNameLabel.snp.bottom)
        }
    }
}

extension TeamRankTableViewCell {
    func setDataBind(rank: Int, teamData: TeamProjectRank) {
        rankNumberLabel.text = "\(rank)"
        userNameLabel.text = teamData.memberNickname
        roleLabel.text = teamData.memberRole
        piecesCountLabel.text = "\(teamData.memberPuzzleCount)"
    }
}
