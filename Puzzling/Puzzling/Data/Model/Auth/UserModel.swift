//
//  UserModel.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/19.
//

import Foundation

struct UserModel {
    
    let name: String?
    let memberId: Int
    let projectId: Int?
    let accessToken: String
    let refreshToken: String
    let isNewUser: Bool

}
