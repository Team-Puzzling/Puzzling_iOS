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
    case myReviewList(memberId: String, projectId: String)
    case reviewDetail(memberId: String, projectId: String, startDate: String, endDate: String)
}

extension MyProjectService: TargetType {
    var baseURL: URL {
        return URL(string: URLConst.baseURL)!
    }

    var path: String {
        switch self {
        case .projectList(let memberId):
            return URLConst.getMemberProjectAllURL.replacingOccurrences(of: "{memberId}", with: "\(memberId)")
        case .myReviewList(let memberId, let projectId):
            return URLConst.getMemberProjectReviewsURL.replacingOccurrences(of: "{memberId}", with: "\(memberId)").replacingOccurrences(of: "{projectId}", with: "\(projectId)")
        case .reviewDetail(let memberId, let projectId, _, _):
            return URLConst.getMemberProjectReviewURL.replacingOccurrences(of: "{memberId}", with: "\(memberId)").replacingOccurrences(of: "{projectId}", with: "\(projectId)")
        }
    }

    var method: Moya.Method {
        switch self {
        case .projectList:
            return .get
        case .myReviewList:
            return .get
        case .reviewDetail:
            return .get
        }
    }

    var task: Moya.Task {
        switch self {
        case .projectList(_):
            return .requestPlain
        case .myReviewList(_, _):
            return .requestPlain
        case .reviewDetail(_, _, let startDate, let endDate):
            let param: [String: Any] = [
                URLConst.startDate: startDate,
                URLConst.endDate: endDate
            ]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        }
    }

    var headers: [String : String]? {
        switch self {
        case .projectList:
            return APIConstants.headerWithAuthorization
        case .myReviewList:
            return APIConstants.headerWithAuthorization
        case .reviewDetail:
            return APIConstants.headerWithAuthorization
        }
    }
}
