//
//  postProjectRequest.swift
//  Puzzling
//
//  Created by KJ on 2023/07/17.
//

import Foundation

// MARK: - ContentResponse

struct PostProjectRequest: Codable {
    let projectName: String
    let projectIntro: String
    let projectStartDate: String
    let memberProjectRole: String
    let memberProjectNickname: String
    let reviewCycle: [String]
}

