//
//  APIConst.swift
//  Puzzling-iOS
//
//  Created by KJ on 2023/07/04.
//

import Foundation

enum NetworkHeaderKey: String {
    case deviceToken = "deviceToken"
    case accessToken = "accesstoken"
    case contentType = "Content-Type"
    case authorization = "Authorization"
}

enum APIConstants {
    
    static let accept: String = "Accept"
    static let auth: String = "x-auth-token"
    static let applicationJSON = "application/json"
    static var deviceToken: String = ""
    static var accessToken: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2ODk2MDY3MTIsImV4cCI6MTY4OTYxMDMxMiwibWVtYmVySWQiOjF9.6kyDSdElC1M6Wr6lT28ZTj4ZV8HT55_bUwvJH2oNn3A"
    
    //MARK: - Header
    
    static var headerWithOutToken: [String: String] {
        [NetworkHeaderKey.contentType.rawValue: APIConstants.applicationJSON]
    }
    
    static var headerWithDeviceToken: [String: String] {
        [
            NetworkHeaderKey.contentType.rawValue: APIConstants.applicationJSON,
            NetworkHeaderKey.deviceToken.rawValue: APIConstants.deviceToken
        ]
    }
    
    static var headerWithAuthorization: [String: String] {
        [
            NetworkHeaderKey.contentType.rawValue: APIConstants.applicationJSON,
            NetworkHeaderKey.authorization.rawValue: URLConst.bearer + APIConstants.accessToken
        ]
    }
}

