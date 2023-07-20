//
//  TeamPuzzleStatusModel.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/16.
//

import Foundation

protocol ModelProtocol {}

protocol TeamModelProtocol: AnyObject {
    var status: TeamPuzzleStatusData { get set }
    var puzzleCount: Int { get set }
    var puzzleAssetNumber: Int { get set }
}

class TeamPuzzleStatusModel: TeamModelProtocol, ModelProtocol {
    var status: TeamPuzzleStatusData
    var puzzleCount: Int
    var puzzleAssetNumber: Int
    
    init(status: TeamPuzzleStatusData, puzzleCount: Int, puzzleAssetNumber: Int) {
        self.status = status
        self.puzzleCount = puzzleCount
        self.puzzleAssetNumber = puzzleAssetNumber
    }
}

struct TeamPuzzleStatusData {
    var isTodayReviewDay: Bool
    var hasReviewed: Bool
    var reviewedMemberPercentage: String
    var reviewDate: String
}
