//
//  ProjectService.swift
//  Puzzling
//
//  Created by KJ on 2023/07/17.
//

import Foundation
import Moya

enum ProjectService {
    case postProject(param: PostProjectRequest, memberID: String)
    case joinProject(memberID: String)
    case invitationCode(memberID: String, invitationCode: String)
}

extension ProjectService: TargetType {
    var baseURL: URL {
        return URL(string: URLConst.baseURL)!
    }
    
    var path: String {
        switch self {
        case .postProject(_, let memberID):
            return URLConst.postProjectURL.replacingOccurrences(of: "{memberId}", with: "\(memberID)")
        case .joinProject(let memberID):
            return URLConst.postProjectJoinURL.replacingOccurrences(of: "{memberId}", with: "\(memberID)")
        case .invitationCode(_, let memberID):
            return URLConst.getInvitationCodeURL.replacingOccurrences(of: "{memberId}", with: "\(memberID)")
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postProject:
            return .post
        case .joinProject:
            return .post
        case .invitationCode:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postProject(let param, _):
            return .requestParameters(parameters: try! param.asParameter(), encoding: JSONEncoding.default)
        case .joinProject:
            return .requestPlain
        case .invitationCode(_, let invitaionCode):
            let param: [String: Any] = [
                URLConst.invitationCode : invitaionCode
            ]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .postProject:
            return APIConstants.headerWithAuthorization
        case .joinProject:
            return APIConstants.headerWithAuthorization
        case .invitationCode:
            return APIConstants.headerWithAuthorization
        }
    }
}
