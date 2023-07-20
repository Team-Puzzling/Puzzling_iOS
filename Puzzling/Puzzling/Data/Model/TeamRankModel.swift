//
//  TeamRankModel.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/15.
//

import Foundation

struct TeamRankModel {
    var userName: String
    var role: String
    var pieces: Int
}

struct TeamRankTopThreeModel {
    var rankNumber: Int?
    var userInformation: TeamRankModel?
}
