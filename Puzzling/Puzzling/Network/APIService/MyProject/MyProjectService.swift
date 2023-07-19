//
//  MyProjectService.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/20.
//


import Foundation
import Moya

enum MyProjectService {
    case projectList(memberId: String)
}

extension MyProjectService: TargetType {
    var baseURL: URL {
        return URL(string: URLConst.baseURL)!
    }

    var path: String {
        switch self {
        case .projectList(let memberId):
            return URLConst.getMemberProjectAllURL.replacingOccurrences(of: "{memberId}", with: "\(memberId)")
        }
    }

    var method: Moya.Method {
        switch self {
        case .projectList:
            return .get
        }
    }

    var task: Moya.Task {
        switch self {
        case .projectList(_):
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        switch self {
        case .projectList:
            return APIConstants.headerWithAuthorization
        }
    }
}
