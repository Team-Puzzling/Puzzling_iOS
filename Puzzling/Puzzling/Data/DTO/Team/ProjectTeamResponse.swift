//
//  ProjectTeamResponse.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/18.
//

import Foundation

protocol TeamResponseProtocol {}

struct ReviewWriters: Codable {
    let memberNickname, memberRole: String
}

struct NonReviewWriters: Codable {
    let memberNickname, memberRole: String
}

struct ProjectTeamResponse: Codable, TeamResponseProtocol {
    let reviewDay, reviewDate: String
    let reviewWriters: [ReviewWriters]?
    let nonReviewWriters: [NonReviewWriters]?
    
    func convertToTeamMemberModel() -> TeamMemberModel {
        return TeamMemberModel(reviewDay: reviewDay, reviewDate: reviewDate, reviewWriters: reviewWriters, nonReviewWriters: nonReviewWriters)
    }
}



