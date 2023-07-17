//
//  InvitationCodeResponse.swift
//  Puzzling
//
//  Created by KJ on 2023/07/18.
//

import Foundation

struct InvitationCodeResponse: Codable {
    let projectCode: String
    
    func convertToInvitationCode() -> InvitationCodeModel {
        return InvitationCodeModel(projectCode: projectCode)
    }
}
