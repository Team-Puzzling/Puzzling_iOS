//
//  TeamRankPodiumCell.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/14.
//

import UIKit

final class TeamRankPodiumCell: UIView {
    
    // MARK: - UI Components
    
    private let puzzleImageView = UIImageView()
    private let podiumImageView = UIImageView()
    private let textStackView = UIStackView()
    private let userNameLabel = UILabel()
    private let roleLabel = UILabel()
    private let piecesCountLabel = UILabel()
    
    // MARK: - Properties
    
    private var piecesCount = 0
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setDelegate()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TeamRankPodiumCell {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        puzzleImageView.do {
            $0.contentMode = .scaleAspectFit
        }
        
        podiumImageView.do {
            $0.contentMode = .scaleAspectFit
        }
        
        userNameLabel.do {
            $0.textColor = .white000
            $0.font = .fontGuide(.body1_bold_kor)
            $0.numberOfLines = 1
        }
        
        roleLabel.do {
            $0.textColor = .white000
            $0.font = .fontGuide(.body3_regular_kor)
            $0.numberOfLines = 1
            $0.adjustsFontSizeToFitWidth = true
        }
        
        piecesCountLabel.do {
            $0.textColor = .white000
            $0.font = .fontGuide(.body3_bold_kor)
            $0.numberOfLines = 1
        }
        
        textStackView.do {
            $0.axis = .vertical
            $0.alignment = .center
            $0.distribution = .equalCentering
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        self.addSubviews(podiumImageView, puzzleImageView, textStackView)
        
        textStackView.addArrangedSubviews(userNameLabel, roleLabel, piecesCountLabel)
        
        podiumImageView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(podiumImageView.snp.width).multipliedBy(1.14)
        }
        
        puzzleImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(podiumImageView.snp.top).offset(-4)
            $0.size.equalTo(43)
        }
        
        textStackView.snp.makeConstraints {
            $0.center.equalTo(podiumImageView.snp.center)
            $0.height.equalTo(podiumImageView.snp.height).dividedBy(1.35)
            $0.horizontalEdges.equalTo(podiumImageView.snp.horizontalEdges).inset(16)
        }
    }
}

extension TeamRankPodiumCell {
    
    // MARK: - Methods
    
    func setPodiumInformation(rankModel: TeamRankTopThreeModel?, rankNumber: Int) {
        switch rankNumber {
        case 1:
            puzzleImageView.image = Image.rank1st
            podiumImageView.image = Image.rank1Podium
        case 2:
            puzzleImageView.image = Image.rank2nd
            podiumImageView.image = Image.rankElsePodium
            userNameLabel.font = .fontGuide(.body3_bold_kor)
            roleLabel.font = .fontGuide(.detail3_regular_kor)
        case 3:
            puzzleImageView.image = Image.rank3rd
            podiumImageView.image = Image.rankElsePodium
            userNameLabel.font = .fontGuide(.body3_bold_kor)
            roleLabel.font = .fontGuide(.detail3_regular_kor)
        default:
            break
        }
        
        if let rank = rankModel?.rankNumber, let userInformation = rankModel?.userInformation {
            piecesCount = userInformation.memberPuzzleCount
            let pieceLabel: String = "\(piecesCount)조각"
            
            piecesCountLabel.text = pieceLabel
            userNameLabel.text = userInformation.memberNickname
            roleLabel.text = userInformation.memberRole
        } else {
            piecesCountLabel.text = nil
            userNameLabel.text = nil
            roleLabel.text = nil
        }
    }
}
