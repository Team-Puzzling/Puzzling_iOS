//
//  TeamDashboardModel.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/12.
//

import Foundation

// MARK: - TeamDashboardModel

/// 📍 [GET] ~/api/v1/project/{projectId}/puzzle?until={}
///  - 팀 대시보드에 퍼즐 관련 데이터를 요청하는 API

/// 📍 Request Header -
///  Content-Type : application/json
///  Authorization : "Bearer Puzzling-AccessToken"

///  📍 Path Variable -
///  1. projectId: Int -> 프로젝트 Id

///  📍 Query Parameter -
///  1. until: String -> 요청 보내는 날짜 (그 날까지의 데이터를 내려줘야 하므로 필요한 값 !)

/// 🔸 Ex) ~/api/v1/dashboard/3/team/puzzle?until=2023-07-05

struct TeamDashboardModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: TeamDashboardData
}

struct TeamDashboardData: Codable {
    let myPuzzle: MyPuzzle
    let teamPuzzleBoard: [TeamPuzzleBoard]
    let teamPuzzleBoardCount: Int
    let isReviewDay, hasTodayReview: Bool
}

struct TeamPuzzleBoard: Codable, ModelProtocol {
    let puzzleAssetName: String
    let reviewMemberPercent, reviewDate: String?
}

// MARK: - TeamProjectRankModel

/// 📍 [GET] ~/api/v1/project/{projectId}/rank
///  - 팀원 회고 랭킹 조회 API

/// 📍 Request Header -
///  Content-Type : application/json
///  Authorization : "Bearer Puzzling-AccessToken"

///  📍 Path Variable -
///  1. projectId: Int -> 프로젝트 Id

/// 🔸 Ex) ~/api/v1/project/3/rank

struct TeamProjectRankModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: [TeamProjectRank]
}

struct TeamProjectRank: Codable {
    let memberRank: Int
    let memberNickname, memberRole: String
    let memberPuzzleCount: Int
}
