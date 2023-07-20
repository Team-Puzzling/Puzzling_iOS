//
//  Profile.swift
//  Puzzling
//
//  Created by KJ on 2023/07/18.
//

struct ProfileModel {
    var projectId: Int
    var memberProjectNickname: String
    var memberProjectRole: String
    
    public func makePostProfileRequest() -> PostProfileRequest {
        return PostProfileRequest(projectId: projectId,
                                  memberProjectNickname: memberProjectNickname,
                                  memberProjectRole: memberProjectRole)
    }
}
