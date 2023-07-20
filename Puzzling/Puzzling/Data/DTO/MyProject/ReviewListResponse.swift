//
//  ReviewListResponse.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/20.
//

import Foundation

struct ReviewListResponse: Codable {
    let reviewId: Int
    let reviewDate: String
    let contents: String
    
    func convertToReiviewListModel() -> ReviewListModel {
        return ReviewListModel(reviewId: reviewId, reviewDate: reviewDate, contents: contents)
    }
}
