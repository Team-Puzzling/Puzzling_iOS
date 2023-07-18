//
//  UserResponse.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/19.
//

import Foundation

struct UserResponse: Codable {
    
    let name: String
    let memberID: Int
    let projectID: Int?
    let accessToken: String
    let refreshToken: String
    let isNewUser: Bool
    
    func convertoToUserModel() -> UserModel {
        return UserModel(name: name, memberID: memberID, projectID: projectID, accessToken: accessToken, refreshToken: refreshToken, isNewUser: isNewUser)
    }
}
