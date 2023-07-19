//
//  ReviewFiveFRequest.swift
//  Puzzling
//
//  Created by 천성우 on 2023/07/19.
//

import UIKit

struct ReviewFiveFRequest: Codable {
    let reviewTemplateId: Int
    let fact: String
    let feeling: String
    let finding: String
    let feedback: String
    let actionPlan: String
}
