//
//  UserResponse.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/19.
//

import Foundation

struct UserResponse: Codable {
    
    let name: String
    let memberId: Int
    let projectId: Int?
    let accessToken: String
    let refreshToken: String
    let isNewUser: Bool
    
    func convertToUserModel() -> UserModel {
        return UserModel(name: name, memberId: memberId, projectId: projectId, accessToken: accessToken, refreshToken: refreshToken, isNewUser: isNewUser)
    }
}
