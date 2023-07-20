//
//  InputContentType.swift
//  Puzzling
//
//  Created by KJ on 2023/07/18.
//

import Foundation

enum InputContentType: CaseIterable {
    case name
    case description
    case role
    case nickname
    case invitationCode
}

enum WarningMessage: CaseIterable {
    case emoji
    case invitationCode
    case duplicateNickname
}
