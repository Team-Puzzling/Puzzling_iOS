//
//  PostProjectProfile.swift
//  Puzzling
//
//  Created by KJ on 2023/07/18.
//

import Foundation

struct PostProfileRequest: Codable {
    let projectId: Int
    let memberProjectNickname: String
    let memberProjectRole: String
}
