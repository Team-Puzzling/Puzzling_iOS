//
//  TeamMemberModel.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/18.
//

import Foundation

struct TeamMemberModel: Codable, TeamResponseProtocol {
    let reviewDay: String
    let reviewDate: String
    let reviewWriters: [ReviewWriters]?
    let nonReviewWriters: [NonReviewWriters]?
}
//
//struct ReviewWriters {
//    let memberNickname: String
//    let memberRole: String
//}
//
//struct NonReviewWriters {
//    let memberNickname: String
//    let memberRole: String
//}
