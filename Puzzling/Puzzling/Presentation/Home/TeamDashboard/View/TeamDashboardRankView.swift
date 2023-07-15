//
//  TeamRankTableView.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/14.
//

import UIKit

import SnapKit
import Then

final class TeamDashboardRankView: UIView {
    
    private let projectTitleLabel = UILabel()
    private let rankView = TeamRankPodiumView()
    private let rankTableView = UITableView()
    
    private var rankTableData: [TeamRankModel] = []
    private lazy var prizeTableData: [TeamRankTopThreeModel] = [TeamRankTopThreeModel(rankNumber: .first, userInformation: <#T##TeamRankModel#>)]
    private lazy var orderedTableData: [TeamRankModel] = rankTableData.sorted {
        ($1.pieces, $0.userName) < ($0.pieces, $1.userName)
    }
    
    private let rankViewHeight: CGFloat = UIScreen.main.bounds.height/5.2
    
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

extension TeamDashboardRankView {
    
    private func setDelegate() {
        rankTableView.dataSource = self
        rankTableView.delegate = self
    }
    
    private func setUI() {
        projectTitleLabel.do {
            $0.textColor = .black000
            $0.font = .fontGuide(.heading4_kor)
        }
        
        rankView.do {
            $0.setRank(firstRank: <#T##TeamRankModel#>, secondRank: <#T##TeamRankModel#>, thirdRank: <#T##TeamRankModel#>)
//            $0.setRank(firstRank: .init(rankNumber: .first, userName: "킹민주", role: "iOS 냥이", pieces: 15), secondRank: .init(rankNumber: .second, userName: "홍정준", role: "아빠", pieces: 11), thirdRank: .init(rankNumber: .third, userName: "정권", role: "이상해씨", pieces: 5))
        }
        
        rankTableView.do {
            $0.registerCell(TeamRankTableViewCell.self)
            $0.allowsSelection = false
            $0.isScrollEnabled = false
        }
    }
    
    private func setLayout() {
        self.addSubviews(projectTitleLabel, rankView, rankTableView)
        
        projectTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        rankView.snp.makeConstraints {
            $0.height.equalTo(rankViewHeight)
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(projectTitleLabel.snp.bottom).offset(16)
        }
        
        rankTableView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(rankView.snp.bottom).offset(10)
            $0.bottom.equalToSuperview()
        }
    }
}

extension TeamDashboardRankView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderedTableData.count - 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueCell(type: TeamRankTableViewCell.self, indexPath: indexPath)
            let rank: Int = indexPath.row + 3
            cell.setDataBind(rank: rank + 1, teamData: orderedTableData[rank])
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
}

extension TeamDashboardRankView {
    func passProjectName(projectName: String) {
        let titleLabel = "\(projectName)의 랭킹"
        projectTitleLabel.text = titleLabel
    }
    
    func passRankTableData(teamRankData: [TeamRankModel]) {
        self.rankTableData = teamRankData
    }
}
