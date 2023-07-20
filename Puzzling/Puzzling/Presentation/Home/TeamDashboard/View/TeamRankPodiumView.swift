//
//  TeamRankPodiumView.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/14.
//

import UIKit

import SnapKit
import Then

final class TeamRankPodiumView: UIView {
    
    private let firstRankView = TeamRankPodiumCell()
    private let secondRankView = TeamRankPodiumCell()
    private let thirdRankView = TeamRankPodiumCell()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDelegate()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TeamRankPodiumView {
    
    private func setDelegate() {}
    
    private func setUI() {}
    
    private func setLayout() {
        self.addSubviews(firstRankView, secondRankView, thirdRankView)
        
        firstRankView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(4.0)
            $0.centerX.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(1.3)
        }
        
        secondRankView.snp.makeConstraints {
            $0.width.equalToSuperview().dividedBy(5.36)
            $0.trailing.equalTo(firstRankView.snp.leading).offset(-32)
            $0.height.equalToSuperview().dividedBy(1.5)
            $0.bottom.equalTo(firstRankView.snp.bottom)
        }
        
        thirdRankView.snp.makeConstraints {
            $0.width.equalToSuperview().dividedBy(5.36)
            $0.leading.equalTo(firstRankView.snp.trailing).offset(32)
            $0.height.equalToSuperview().dividedBy(1.5)
            $0.bottom.equalTo(firstRankView.snp.bottom)
        }
    }
}

extension TeamRankPodiumView {
    func setRank(ranks: [TeamRankTopThreeModel]) {
        firstRankView.setPodiumInformation(rankModel: ranks[0])
        secondRankView.setPodiumInformation(rankModel: ranks[1])
        thirdRankView.setPodiumInformation(rankModel: ranks[2])
    }
}
