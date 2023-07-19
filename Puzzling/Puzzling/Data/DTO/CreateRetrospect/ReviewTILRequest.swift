//
//  ReviewTILRequest.swift
//  Puzzling
//
//  Created by 천성우 on 2023/07/19.
//

import UIKit

struct ReviewTILRequest: Codable {
    let reviewTemplateId: Int
    let liked: String
    let lacked: String
    let actionPlan: String
}
