//
//  Project.swift
//  Puzzling
//
//  Created by KJ on 2023/07/17.
//

import Foundation

struct Project {
    var projectName: String
    var projectIntro: String
    var projectStartDate: String
    var memberProjectRole: String
    var memberProjectNickname: String
    var reviewCycle: [String]
    
    func makePostProjectRequest() -> PostProjectRequest {
        return PostProjectRequest(projectName: projectName,
                                  projectIntro: projectIntro,
                                  projectStartDate: projectStartDate,
                                  memberProjectRole: memberProjectRole,
                                  memberProjectNickname: memberProjectNickname,
                                  reviewCycle: reviewCycle)
    }
}
