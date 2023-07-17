//
//  CreateRetrospectService.swift
//  Puzzling
//
//  Created by 천성우 on 2023/07/18.
//

import Foundation
import Moya

enum CreateRetrospectService {
    case reviewTemplate
    case reviewTIL(memberID: String, projectID: String)
    case reviewFiveF(memberID: String, projectID: String)
    case reivewAAR(memberID: String, projectID: String)
    case previousTemplate(memberID: String, projectID: String)
}

extension CreateRetrospectService: TargetType {
    var baseURL: URL {
        return URL(string: URLConst.baseURL)!
    }
    
    var path: String {
        switch self {
        case .reviewTemplate:
            return URLConst.getReviewTemplateURL
        case .reviewTIL(let memberID, let projectID):
            return URLConst.postReviewTILURL
                .replacingOccurrences(of: "{memberId}", with: "\(memberID)")
                .replacingOccurrences(of: "{projectId}", with: "\(projectID)")
        case .reviewFiveF(let memberID, let projectID):
            return URLConst.postReview5FURL
                .replacingOccurrences(of: "{memberId}", with: "\(memberID)")
                .replacingOccurrences(of: "{projectId}", with: "\(projectID)")
        case .reivewAAR(let memberID, let projectID):
            return URLConst.postReviewARRURL
                .replacingOccurrences(of: "{memberId}", with: "\(memberID)")
                .replacingOccurrences(of: "{projectId}", with: "\(projectID)")
        case .previousTemplate(let memberID, let projectID):
            return URLConst.getReviewPreviousTemplateURL
                .replacingOccurrences(of: "{memberId}", with: "\(memberID)")
                .replacingOccurrences(of: "{projectId}", with: "\(projectID)")
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .reviewTemplate:
            return .get
        case .reviewTIL:
            return .post
        case .reviewFiveF:
            return .post
        case .reivewAAR:
            return .post
        case .previousTemplate:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
//            우당탕탕
        case .reviewTemplate:
            return .requestPlain
        case .reviewTIL(memberID: let memberID, projectID: let projectID):
            return .requestPlain
        case .reviewFiveF(memberID: let memberID, projectID: let projectID):
            return .requestPlain
        case .reivewAAR(memberID: let memberID, projectID: let projectID):
            return .requestPlain
        case .previousTemplate(memberID: let memberID, projectID: let projectID):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .reviewTemplate:
            return APIConstants.headerWithAuthorization
        case .reviewTIL:
            return APIConstants.headerWithAuthorization
        case .reviewFiveF:
            return APIConstants.headerWithAuthorization
        case .reivewAAR:
            return APIConstants.headerWithAuthorization
        case .previousTemplate:
            return APIConstants.headerWithAuthorization
        }
    }
}
