//
//  IndivisualPuzzleStatusModel.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/16.
//

import Foundation

protocol IndivisualModelProtocol: AnyObject {
    var reviewId: Int? { get set }
    var status: IndivisualPuzzleStatusData { get set }
    var puzzleAssetNumber: Int { get set }
}

class IndivisualPuzzleStatusModel: IndivisualModelProtocol, ModelProtocol {
    var reviewId: Int?
    var status: IndivisualPuzzleStatusData
    var puzzleAssetNumber: Int
    
    init(reviewId: Int?, status: IndivisualPuzzleStatusData, puzzleAssetNumber: Int) {
        self.reviewId = reviewId
        self.status = status
        self.puzzleAssetNumber = puzzleAssetNumber
    }
}

struct IndivisualPuzzleStatusData {
    var isTodayReviewDay: Bool
    var hasReviewed: Bool
    var reviewDate: String
}

