//
//  URLConst.swift
//  Puzzling-iOS
//
//  Created by KJ on 2023/07/04.
//

import Foundation

public enum URLConst {
    
    //MARK: - Base URL
    
    public static let baseURL = "http://3.39.174.107"
    
    //MARK: - URL Path
    
    static let postUserURL = "/api/v1/auth"
    static let getUserTokenURL = "/api/v1/auth/token"
    
    static let getReviewTemplateURL = "/api/v1/review/template"
    static let postMemeberURL = "/api/v1/member"
    static let postProjectURL = "/project"
    static let postReviewTILURL = "/review/TIL"
    static let postReivew5FURL = "/review/5F"
    static let postReviewAAR = "/review/ARR"
    static let getReviewPreviousTemplateURL = "/review/previous-template"
    
    static let postJoinURL = "/project/join"
    static let getInvitationCodeURL = "/api/v1/project/verify"
    static let invitationCode = "invitationCode"
    static let getCycleURL = "/cycle"
    
    static let getPuzzleURL = "/puzzle"
    static let today = "today"
    static let getActionPlanURL = "/actionplan"
    static let getProjectAllURL = "/project/all"
    
    static let getTeamPuzzleURL = "/team/puzzle"
    static let getRankURL = "/rank"
    static let startDate = "startDate"
    static let endDate = "endDate"
}
