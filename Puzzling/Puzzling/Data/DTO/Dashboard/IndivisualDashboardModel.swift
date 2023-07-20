//
//  IndivisualDashboardModel.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/12.
//

import Foundation

// MARK: - IndivisualDashBoardModel

/// 📍 [GET] - ~/api/v1/member/{memberId}/project/{projectId}/puzzle?until={}
/// - 개인 대시보드 (홈 뷰)에 퍼즐 관련 데이터를 요청하는 API
/// - 이 API 에서 "오늘이 회고 진행 일"인지 판단 같이 하는게 좋을 것 같아서요 ! 여기서 같이 데이터 내려드려도 될까요 ? [미정]

/// 📍 Request Header -
///  Content-Type : application/json
///  Authorization : "Bearer Puzzling-AccessToken"

///  📍 Path Variable -
///  1. memberId: Int -> 유저 Id
///  2. projectId: Int -> 프로젝트 Id

///  📍 Query Parameter -
///  1. until: String -> 요청 보내는 날짜 (그 날까지의 데이터를 내려줘야 하므로 필요한 값 !)

/// 🔸 Ex) ~/api/v1/member/3/project/4/puzzle?until=2023-07-05

struct IndivisualDashboardModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: IndivisualData
}

struct IndivisualData: Codable {
    let myPuzzle: MyPuzzle
    let userPuzzleBoard: [UserPuzzleBoard]
    let puzzleBoardCount: Int
    let isReviewDay, hasTodayReview: Bool
}

struct MyPuzzle: Codable {
    let nickname: String
    let puzzleCount: Int
}

struct UserPuzzleBoard: Codable, ModelProtocol {
    let puzzleAssetName: String
    let reviewDate: String?
    let reviewId: Int?
}

// MARK: - ActionPlanModel

/// 📍 [GET] - ~/api/v1/member/{memberId}/project/{projectId}/actionplan
///  - ActionPlan 내용 조회 API

/// 📍 Request Header -
///  Content-Type : application/json
///  Authorization : "Bearer Puzzling-AccessToken"

///  📍 Path Variable -
///  1. memberId: Int -> 유저 Id
///  2. projectId: Int -> 프로젝트 Id

/// 🔸 Ex) ~/api/v1/member/2/project/3/actionplan

struct ActionPlanModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: [ActionPlan]
}

struct ActionPlan: Codable {
    let actionPlanContent, actionPlanDate: String
}

// MARK: - OngoingProjectsModel

/// 📍 [GET] - ~/api/v1/member/{memberId}/project/all
///  - 진행 중인 프로젝트 리스트 조회 API

/// 📍 Request Header -
///  Content-Type : application/json
///  Authorization : "Bearer Puzzling-AccessToken"

///  📍 Path Variable -
///  1. memberId: Int -> 유저 Id

/// 🔸 Ex) ~/api/v1/member/2/project/all

struct OngoingProjectsModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: [OngoingProjectData]
}

struct OngoingProjectData: Codable {
    let projectId: Int
    let projectName, projectStartDate: String
}

