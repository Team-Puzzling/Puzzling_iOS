//
//  ReviewFiveFModel.swift
//  Puzzling
//
//  Created by 천성우 on 2023/07/19.
//

import Foundation

struct ReviewFiveFModel {
    var reviewTemplateId: Int
    var fact: String
    var feeling: String
    var finding: String
    var feedback: String
    var actionPlan: String
    
    func makePostReviewFiveFResponce() -> ReviewFiveFRequest {
        return ReviewFiveFRequest(reviewTemplateId: reviewTemplateId, fact: fact, feeling: feeling,
                                  finding: finding, feedback: feedback, actionPlan: actionPlan)
    }
}
