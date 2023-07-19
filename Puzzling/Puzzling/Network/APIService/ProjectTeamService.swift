//
//  ProjectTeamService.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/18.
//

import Foundation
import Moya

enum ProjectTeamService {
    case teamMember(projectId: String, startDate: String, endDate: String)
}

extension ProjectTeamService: TargetType {
    var baseURL: URL {
        return URL(string: URLConst.baseURL)!
    }

    var path: String {
        switch self {
        case .teamMember(let projectId, _, _):
            return URLConst.getProjectTeamReviewURL.replacingOccurrences(of: "{projectId}", with: "\(projectId)")
        }
    }

    var method: Moya.Method {
        switch self {
        case .teamMember:
            return .get
        }
    }

    var task: Moya.Task {
        switch self {
        case .teamMember(_, let startDate, let endDate):
            let param: [String: Any] = [
                URLConst.startDate: startDate,
                URLConst.endDate: endDate
            ]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        }
    }

    var headers: [String : String]? {
        switch self {
        case .teamMember:
            return APIConstants.headerWithAuthorization
        }
    }
}
