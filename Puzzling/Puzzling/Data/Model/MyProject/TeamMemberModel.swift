//
//  TeamMemberModel.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/18.
//

import Foundation

struct TeamMemberModel: Codable {
    let reviewDay: String
    let reviewDate: String
    let reviewWriters: [ReviewWriters]?
    let nonReviewWriters: [NonReviewWriters]?
}
