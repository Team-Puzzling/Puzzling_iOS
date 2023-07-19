//
//  reviewTILModel.swift
//  Puzzling
//
//  Created by 천성우 on 2023/07/19.
//

import Foundation

struct ReviewTILModel {
    var reviewTemplateId: Int
    var liked: String
    var lacked: String
    var actionPlan: String
    
    func makePostReviewTILResponce() -> ReviewTILRequest {
        return ReviewTILRequest(reviewTemplateId: reviewTemplateId, liked: liked, lacked: lacked,
                                 actionPlan: actionPlan)
    }
}
