//
//  ProjectCycleModel.swift
//  Puzzling
//
//  Created by KJ on 2023/07/12.
//

import UIKit

struct ProjectCycleModel {
    let dayOfWeek: String
}

extension ProjectCycleModel {
    
    static func projectCycleModelData() -> [ProjectCycleModel] {
        return [
            ProjectCycleModel(dayOfWeek: "월"),
            ProjectCycleModel(dayOfWeek: "화"),
            ProjectCycleModel(dayOfWeek: "수"),
            ProjectCycleModel(dayOfWeek: "목"),
            ProjectCycleModel(dayOfWeek: "금"),
            ProjectCycleModel(dayOfWeek: "토"),
            ProjectCycleModel(dayOfWeek: "일")
        ]
    }
}
