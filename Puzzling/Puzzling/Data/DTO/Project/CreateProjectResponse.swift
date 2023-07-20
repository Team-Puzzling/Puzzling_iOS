//
//  InvitationCodeResponse.swift
//  Puzzling
//
//  Created by KJ on 2023/07/18.
//

import Foundation

struct CreateProjectResponse: Codable {
    let projectCode: String
    let projectId: Int
    
    func convertToCreateProjectModel() -> CreateProjectModel {
        return CreateProjectModel(projectCode: projectCode, projectId: projectId)
    }
}
