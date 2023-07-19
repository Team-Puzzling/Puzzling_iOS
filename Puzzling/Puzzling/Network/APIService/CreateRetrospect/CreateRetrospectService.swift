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
    case reviewTIL(param: ReviewTILRequest, memberID: String, projectID: String)
    case reviewFiveF(param: ReviewFiveFRequest,memberID: String, projectID: String)
    case reivewAAR(param: ReviewAARRequest, memberID: String, projectID: String)
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
        case .reviewTIL(_, let memberID, let projectID):
            return URLConst.postReviewTILURL
                .replacingOccurrences(of: "{memberId}", with: "\(memberID)")
                .replacingOccurrences(of: "{projectId}", with: "\(projectID)")
        case .reviewFiveF(_, let memberID, let projectID):
            return URLConst.postReview5FURL
                .replacingOccurrences(of: "{memberId}", with: "\(memberID)")
                .replacingOccurrences(of: "{projectId}", with: "\(projectID)")
        case .reivewAAR(_, let memberID, let projectID):
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
        case .reviewTemplate:
            return .requestPlain
        case .reviewTIL(let param, _, _): // 진짜 권정 멋 지 다 ! 🪀
            return .requestParameters(parameters: try! param.asParameter(), encoding: JSONEncoding.default)
        case .reviewFiveF(let param, _, _):
            return .requestParameters(parameters: try! param.asParameter(), encoding: JSONEncoding.default)
        case .reivewAAR(let param, _, _):
            return .requestParameters(parameters: try! param.asParameter(), encoding: JSONEncoding.default)
        case .previousTemplate(_, _):
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
