//
//  ReviewAARRequest.swift
//  Puzzling
//
//  Created by 천성우 on 2023/07/19.
//

import UIKit

struct ReviewAARRequest: Codable {
    let reviewTemplateId: Int
    let initialGoal: String
    let result: String
    let difference: String
    let persistence: String
    let actionPlan: String
}
