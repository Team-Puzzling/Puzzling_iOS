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
    private var rankView = TeamRankPodiumView()
    private let rankTableView = UITableView()

    private var orderedTableData: [TeamProjectRank] = []
    
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
        
        rankTableView.do {
            $0.register(TeamRankTableViewCell.self, forCellReuseIdentifier: "rankTable")
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
        if orderedTableData.count - 3 < 0 {
            return 0
        } else {
            return orderedTableData.count - 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "rankTable", for: indexPath) as? TeamRankTableViewCell else {
            return UITableViewCell() }
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
    
    func passTopThreeData(data: [TeamProjectRank]) {
        var defaultTopThreeData: [TeamRankTopThreeModel] = [.init(rankNumber: nil, userInformation: nil), .init(rankNumber: nil, userInformation: nil), .init(rankNumber: nil, userInformation: nil)]
        
        switch data.count {
        case 0:
            self.rankView.setRank(ranks: defaultTopThreeData)
        case 1:
            defaultTopThreeData[0].rankNumber = 1
            defaultTopThreeData[0].userInformation = data[0]
            self.rankView.setRank(ranks: defaultTopThreeData)
        case 2:
            defaultTopThreeData[0].rankNumber = 1
            defaultTopThreeData[0].userInformation = data[0]
            defaultTopThreeData[1].rankNumber = 2
            defaultTopThreeData[1].userInformation = data[1]
            self.rankView.setRank(ranks: defaultTopThreeData)
        default:
            defaultTopThreeData[0].rankNumber = 1
            defaultTopThreeData[0].userInformation = data[0]
            defaultTopThreeData[1].rankNumber = 2
            defaultTopThreeData[1].userInformation = data[1]
            defaultTopThreeData[2].rankNumber = 3
            defaultTopThreeData[2].userInformation = data[2]
            self.rankView.setRank(ranks: defaultTopThreeData)
        }
    }
    
    func passOrderedRankData(data: [TeamProjectRank]) {
        self.orderedTableData = data
        self.rankTableView.reloadData()
    }
}
