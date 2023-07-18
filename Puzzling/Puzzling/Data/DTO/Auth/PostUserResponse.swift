//
//  PostUserResponse.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/19.
//

import Foundation

struct PostUserResponse: Codable {
    
    let name: String
    let memberID: Int
    let projectID: Int?
    let accessToken: String
    let refreshToken: String
    let isNewUser: Bool
    
}
