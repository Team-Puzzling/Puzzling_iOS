//
//  ReviewAARModel.swift
//  Puzzling
//
//  Created by 천성우 on 2023/07/19.
//

import Foundation

struct ReviewAARModel {
    var reviewTemplateId: Int
    var initialGoal: String
    var result: String
    var difference: String
    var persistence: String
    var actionPlan: String
    
    func makePostReviewAARResponce() -> ReviewAARRequest {
        return ReviewAARRequest(reviewTemplateId: reviewTemplateId, initialGoal: initialGoal, result: result,
                                difference: difference, persistence: persistence, actionPlan: actionPlan)
    }
}
