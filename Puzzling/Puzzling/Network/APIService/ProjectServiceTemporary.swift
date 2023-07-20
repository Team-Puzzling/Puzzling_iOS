//
//  ProjectService.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/16.
//

import UIKit

import Moya

protocol ProjectNetworkingProtocol: AnyObject {
    func NOTNAMEDPROPERLY()
}

enum ProjectServiceKBS {
    case fetchIndivisualPuzzle(memberId: Int, projectId: Int, todayString: String)
    case fetchActionPlans(memberId: Int, projectId: Int)
    case fetchOngoingProjectList(memberId: Int)
    case fetchTeamPuzzle(projectId: Int, todayString: String)
    case fetchTeamRankTable(projectId: Int)
    case fetchRetrospectCycle(projectId: Int)
}

extension ProjectServiceKBS: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "http://3.39.174.107") else {
            print("Failed converting URL")
            return URL(string: "")! }
        return url
    }
    
    var path: String {
        switch self {
        case .fetchIndivisualPuzzle(let memberId, let projectId, let todayString):
            return URLConst.getMemberProjectPuzzleURL.replacingOccurrences(of: "{memberId}", with: "\(memberId)").replacingOccurrences(of: "{projectId}", with: "\(projectId)")
        case .fetchActionPlans(let memberId, let projectId):
            return URLConst.getMemberProjectActionplanURL.replacingOccurrences(of: "{memberId}", with: "\(memberId)").replacingOccurrences(of: "{projectId}", with: "\(projectId)")
        case .fetchOngoingProjectList(let memberId):
            return URLConst.getMemberProjectAllURL.replacingOccurrences(of: "{memberId}", with: "\(memberId)")
        case .fetchTeamPuzzle(let projectId, let todayString):
            return URLConst.getTeamProjectPuzzleURL.replacingOccurrences(of: "{projectId}", with: "\(projectId)")
        case .fetchTeamRankTable(let projectId):
            return URLConst.getProjectRankURL.replacingOccurrences(of: "{projectId}", with: "\(projectId)")
        case .fetchRetrospectCycle(projectId: let projectId):
            return URLConst.getProjectCycleURL.replacingOccurrences(of: "{projectId}", with: "\(projectId)")
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchIndivisualPuzzle:
            return .get
        case .fetchActionPlans:
            return .get
        case .fetchOngoingProjectList:
            return .get
        case .fetchTeamPuzzle:
            return .get
        case .fetchTeamRankTable:
            return .get
        case .fetchRetrospectCycle:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchIndivisualPuzzle(_, _, let todayString):
            let parameter: [String: Any] = [URLConst.today: todayString]
            return .requestParameters(parameters: parameter, encoding: URLEncoding.default)
        case .fetchActionPlans:
            return .requestPlain
        case .fetchOngoingProjectList:
            return .requestPlain
        case .fetchTeamPuzzle(_, let todayString):
            let parameter: [String: Any] = [URLConst.today: todayString]
            return .requestParameters(parameters: parameter, encoding: URLEncoding.default)
        case .fetchTeamRankTable:
            return .requestPlain
        case .fetchRetrospectCycle:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return APIConstants.headerWithAuthorization
    }
    
//    var authorizationType: AuthorizationType? {
//        return .bearer
//    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func NOTNAMEDPROPERLY() {
        
    }
}
