//
//  ProjectListResponse.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/20.
//

import Foundation

struct ProjectListResponse: Codable {
    let projectId: Int
    let projectStartDate: String
    let projectName: String
    
    func convertToProjectListModel() -> ProjectListModel {
        return ProjectListModel(projectID: projectId, projectStartDate: projectStartDate, projectName: projectName)
    }
}
