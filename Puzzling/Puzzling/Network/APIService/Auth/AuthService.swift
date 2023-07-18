//
//  AuthService.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/19.
//

import Foundation
import Moya

enum AuthService {
    case postAuth(param: PostAuthRequest, token: String)
    case authToken
}

extension AuthService: TargetType {
    var baseURL: URL {
        return URL(string: URLConst.baseURL)!
    }

    var path: String {
        switch self {
        case .postAuth(_, _):
            return URLConst.postUserURL
        case .authToken:
            return URLConst.getUserTokenURL
        }
    }

    var method: Moya.Method {
        switch self {
        case .postAuth:
            return .post
        case .authToken:
            return .get
        }
    }

    var task: Moya.Task {
        switch self {
        case .postAuth(let param, _):
            return .requestParameters(parameters: try! param.asParameter(), encoding: JSONEncoding.default)
        case .authToken:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        switch self {
        case .postAuth(_, let token):
            APIConstants.accessToken = token
            return APIConstants.headerWithAuthorization
        case .authToken:
            return APIConstants.headerWithAuthorization
        }
    }
}
