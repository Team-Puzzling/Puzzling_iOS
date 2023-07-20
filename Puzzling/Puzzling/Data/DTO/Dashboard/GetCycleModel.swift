//
//  GetCycleModel.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/19.
//

import Foundation

struct GetCycleModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: ProjectCycle
}

struct ProjectCycle: Codable {
    let projectName, projectReviewCycle: String
}
