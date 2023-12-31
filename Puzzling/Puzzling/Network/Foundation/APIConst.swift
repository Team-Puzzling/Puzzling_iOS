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
    case refresh = "Refresh"
}

enum APIConstants {
    
    static let accept: String = "Accept"
    static let auth: String = "x-auth-token"
    static let applicationJSON = "application/json"
    static var deviceToken: String = ""
    static var jwtToken: String = ""
    static var accessToken: String = KeyChain.read(key: "accessToken") ?? ""
    static var kakaoAccessToken: String = ""
    static var authorization: String = ""
    static var refresh: String = ""
    
    //MARK: - Header
    
    static var headerWithOutToken: [String: String] {
        [NetworkHeaderKey.contentType.rawValue: APIConstants.applicationJSON]
    }
    
    static var headerWithDeviceToken: [String: String] {
        [
            NetworkHeaderKey.contentType.rawValue: APIConstants.applicationJSON,
            NetworkHeaderKey.authorization.rawValue: URLConst.bearer + APIConstants.accessToken
        ]
    }
    
    static var headerWithAuthorization: [String: String] {
        [
            NetworkHeaderKey.contentType.rawValue: APIConstants.applicationJSON,
            NetworkHeaderKey.authorization.rawValue: URLConst.bearer + APIConstants.accessToken
        ]
    }
    
    static var headerWithKakaoAuthorization: [String: String] {
        [
            NetworkHeaderKey.contentType.rawValue: APIConstants.applicationJSON,
            NetworkHeaderKey.authorization.rawValue: URLConst.bearer + APIConstants.kakaoAccessToken
        ]
    }
    
    static var headerWithRefresh: [String: String] {
        [
            NetworkHeaderKey.contentType.rawValue: APIConstants.applicationJSON,
            NetworkHeaderKey.authorization.rawValue: URLConst.bearer + APIConstants.accessToken
        ]
    }
}

