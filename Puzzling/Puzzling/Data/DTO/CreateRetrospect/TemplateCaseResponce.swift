//
//  TemplateCaseResponce.swift
//  Puzzling
//
//  Created by 천성우 on 2023/07/18.
//

import UIKit

struct TemplateCaseResponce: Codable {
    let reviewTemplateId: Int
    let reviewTemplateName: String
    let reviewTemplateMeaning: String
    
    func converToTemplateCase() -> TemplateCaseModel {
        return TemplateCaseModel(reviewTemplateId: self.reviewTemplateId, reviewTemplateName: self.reviewTemplateName, reviewTemplateMeaning: self.reviewTemplateMeaning)
    }
}
