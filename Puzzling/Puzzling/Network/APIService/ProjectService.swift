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

final class ProjectService: ProjectNetworkingProtocol {
    
    private var dummyData: [TeamRankModel] = [TeamRankModel(userName: "aa", role: "iOS Dev", pieces: 17), TeamRankModel(userName: "bb", role: "PM", pieces: 12), TeamRankModel(userName: "cc", role: "AOS Dev", pieces: 14), TeamRankModel(userName: "dd", role: "Server-T", pieces: 9), TeamRankModel(userName: "ee", role: "AOS Dev", pieces: 40), TeamRankModel(userName: "ff", role: "iOS Dev", pieces: 22), TeamRankModel(userName: "gg", role: "UXUI Designer", pieces: 14)]
    
    func NOTNAMEDPROPERLY() {
        
    }
}

extension ProjectService {
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
            print("✅")

            for rank in 0...2 {
                topThreeData.append(.init(rankNumber: rank + 1, userInformation: sortedData[rank]))
            }
            print()
        } else {
            print("✅")
            for rank in 0...sortedData.count {
                topThreeData.append(.init(rankNumber: rank + 1, userInformation: sortedData[rank]))
            }
        }
        return topThreeData
    }
    
    
}
