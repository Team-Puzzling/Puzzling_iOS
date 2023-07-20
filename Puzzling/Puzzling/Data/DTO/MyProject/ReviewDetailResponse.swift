//
//  ReviewDetailResponse.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/20.
//

import Foundation

struct ReviewDetailResponse: Codable {
    let reviewId: Int?
    let reviewDay: String
    let reviewDate: String
    let reviewTemplateId: Int?
    let contents: [Contents]?
    
    func convertToReviewDetailModel() -> ReviewDetailModel {
        return ReviewDetailModel(reviewId: reviewId, reviewDay: reviewDay, reviewDate: reviewDate, reviewTemplateId: reviewTemplateId, contents: contents)
    }
}

struct Contents: Codable {
    let title: String
    let content: String
}
