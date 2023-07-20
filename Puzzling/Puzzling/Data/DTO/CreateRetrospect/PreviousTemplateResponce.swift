//
//  PreviousTemplateResponce.swift
//  Puzzling
//
//  Created by 천성우 on 2023/07/18.
//

import UIKit

struct PreviousTemplateResponce: Codable {
    let previousTemplateId: Int
    
    func convertToPreviousTemplate() -> PreviousTemplateModel {
        return PreviousTemplateModel(previousTemplateId: self.previousTemplateId)
    }
}
