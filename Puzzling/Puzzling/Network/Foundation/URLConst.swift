//
//  URLConst.swift
//  Puzzling-iOS
//
//  Created by KJ on 2023/07/04.
//

import Foundation

public enum URLConst {
    
    //MARK: - Base URL
    
    static let baseURL = "http://3.39.174.107"
    
    //MARK: - URL Path
    
    // Auth 관련
    
    static let postUserURL = "/api/v1/auth"
    static let getUserTokenURL = "/api/v1/auth/token"
    
    // 회고 작성
    
    static let getReviewTemplateURL = "/api/v1/review/template"
    static let postReviewTILURL = "/api/v1/member/{memberId}/project/{projectId}/review/TIL"
    static let postReview5FURL = "/api/v1/member/{memberId}/project/{projectId}/review/5F"
    static let postReviewARRURL = "/api/v1/member/{memberId}/project/{projectId}/review/ARR"
    static let getReviewPreviousTemplateURL = "/api/v1/member/{memberId}/project/{projectId}/review/previous-template"
    
    // 프로젝트
    
    static let postProjectURL = "/api/v1/member/{memberId}/project"
    static let postProjectJoinURL = "/api/v1/member/{merberId}/project/join"
    static let getInvitationCodeURL = "/api/v1/project/verify"
    static let getProjectCycleURL = "/api/v1/project/{projectId}/cycle"
    
    // 개인 회고
    
    static let getMemberProjectPuzzleURL = "/api/v1/member/{memberId}/project/{projectId}/puzzle"
    static let getMemberProjectActionplanURL = "/api/v1/member/{memberId}/project/{projectId}/actionplan"
    static let getMemberProjectAllURL = "/api/v1/member/{memberId}/project/all"
    static let getProjectAllURL = "/project/all"
    
    // 팀 회고
    
    static let getTeamProjectPuzzleURL = "/api/v1/project/{projectId}/team/puzzle"
    static let getProjectRankURL = "/api/v1/project/{projectId}/rank"
    static let getProjectTeamReviewURL = "/api/v1/project/{projectId}/team/review"
    
    // My
    
    static let getMemberProjectReviewsURL = "/api/v1/member/{memberId}/project/{projectId}/reviews"
    static let getMemberProjectReviewURL = "~/api/v1/member/{memberId}/project/{projectId}/review"
    
    static let startDate = "startDate"
    static let endDate = "endDate"
    static let today = "today"
    static let invitationCode = "invitationCode"
    static let bearer = "Bearer "
}
