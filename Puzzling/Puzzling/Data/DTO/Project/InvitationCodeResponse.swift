//
//  InvitationCodeResponse.swift
//  Puzzling
//
//  Created by KJ on 2023/07/18.
//

import Foundation

struct InvitationCodeResponse: Codable {
    let projectCode: String
    let projectId: Int
    
    func convertToInvitationCode() -> InvitationCodeModel {
        return InvitationCodeModel(projectCode: projectCode, projectId: projectId)
    }
}
