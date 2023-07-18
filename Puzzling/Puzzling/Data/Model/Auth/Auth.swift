//
//  Auth.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/19.
//

import Foundation

struct Auth {
    var socialPlatform: String
    
    public func makePostAuthRequest() -> PostAuthRequest {
        return PostAuthRequest(socialPlatform: socialPlatform)
    }
}
