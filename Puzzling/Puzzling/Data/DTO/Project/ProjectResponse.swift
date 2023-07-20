//
//  ProjectResponse.swift
//  Puzzling
//
//  Created by KJ on 2023/07/18.
//

import Foundation

struct ProjectResponse: Codable {
    let projectId: Int
    let projectName: String
    
    func convertToProjectModel() -> ProjectModel {
        return ProjectModel(projectId: self.projectId, projectName: self.projectName)
    }
}
