//
//  ProjectService.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/16.
//

import UIKit

protocol ProjectNetworkingProtocol: AnyObject {
    func NOTNAMEDPROPERLY()
}

final class ProjectServiceTemporary: ProjectNetworkingProtocol {
    
    private var dummyData: [TeamRankModel] = [TeamRankModel(userName: "aa", role: "iOS Dev", pieces: 17), TeamRankModel(userName: "bb", role: "PM", pieces: 12), TeamRankModel(userName: "cc", role: "AOS Dev", pieces: 14), TeamRankModel(userName: "dd", role: "Server-T", pieces: 9), TeamRankModel(userName: "ee", role: "AOS Dev", pieces: 40), TeamRankModel(userName: "ff", role: "iOS Dev", pieces: 22), TeamRankModel(userName: "gg", role: "UXUI Designer", pieces: 14)]
    
    private var dummyIndivisualPuzzleData: [IndivisualPuzzleStatusModel] = [IndivisualPuzzleStatusModel(reviewId: 1, status: .init(isTodayReviewDay: false, hasReviewed: true, reviewDate: "2023-07-01"), puzzleAssetNumber: 2), IndivisualPuzzleStatusModel(reviewId: 2, status: .init(isTodayReviewDay: false, hasReviewed: true, reviewDate: "2023-07-07"), puzzleAssetNumber: 4), IndivisualPuzzleStatusModel(reviewId: 3, status: .init(isTodayReviewDay: false, hasReviewed: true, reviewDate: "2023-07-11"), puzzleAssetNumber: 7), IndivisualPuzzleStatusModel(reviewId: 4, status: .init(isTodayReviewDay: true, hasReviewed: false, reviewDate: "2023-07-19"), puzzleAssetNumber: 3)]
    
    private var dummyTeamPuzzleData: [TeamPuzzleStatusModel] = [TeamPuzzleStatusModel(status: .init(isTodayReviewDay: false, hasReviewed: true, reviewedMemberPercentage: "A", reviewDate: "2023-07-01"), puzzleCount: 5, puzzleAssetNumber: 4), TeamPuzzleStatusModel(status: .init(isTodayReviewDay: false, hasReviewed: true, reviewedMemberPercentage: "B", reviewDate: "2023-07-07"), puzzleCount: 8, puzzleAssetNumber: 4), TeamPuzzleStatusModel(status: .init(isTodayReviewDay: false, hasReviewed: true, reviewedMemberPercentage: "C", reviewDate: "2023-07-11"), puzzleCount: 4, puzzleAssetNumber: 4), TeamPuzzleStatusModel(status: .init(isTodayReviewDay: true, hasReviewed: true, reviewedMemberPercentage: "D", reviewDate: "2023-07-19"), puzzleCount: 2, puzzleAssetNumber: 4)]
    
    func NOTNAMEDPROPERLY() {
        
    }
}

extension ProjectServiceTemporary {
    func getSortedData() -> [TeamRankModel] {
        let sortedArray = self.dummyData.sorted {
            ($1.pieces, $0.userName) < ($0.pieces, $1.userName)
        }
        return sortedArray
    }
    
    func getTopThreeData() -> [TeamRankTopThreeModel] {
        let sortedData = self.getSortedData()
        var topThreeData: [TeamRankTopThreeModel] = []
        if sortedData.isEmpty {
            // 비어있을 때의 화면 UI 를 받으면 처리하기
            return []
        }
        
        if sortedData.count > 2 {
            for rank in 0...2 {
                topThreeData.append(.init(rankNumber: rank + 1, userInformation: sortedData[rank]))
            }
            print()
        } else {
            for rank in 0...sortedData.count {
                topThreeData.append(.init(rankNumber: rank + 1, userInformation: sortedData[rank]))
            }
        }
        return topThreeData
    }
}

extension ProjectServiceTemporary {
    func getPuzzleData(type: DashboardType) -> [ModelProtocol] {
        switch type {
        case .indivisual:
            return dummyIndivisualPuzzleData
        case .team:
            return dummyTeamPuzzleData
        }
    }
}
