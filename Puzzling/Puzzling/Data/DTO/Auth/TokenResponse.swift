//
//  TokenResponse.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/20.
//

import Foundation

struct TokenResponse: Codable {
    let accessToken: String
    
    func convertToTokenModel() -> TokenModel {
        return TokenModel(accessToken: accessToken)
    }
}
