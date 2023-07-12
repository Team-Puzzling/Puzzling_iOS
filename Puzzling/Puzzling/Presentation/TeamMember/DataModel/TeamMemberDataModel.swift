//
//  WhoWriteReviewsDataModel.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/10.
//

import UIKit

struct Icon {
    static let downIcon = UIImage(systemName: "chevron.down")?
        .withTintColor(.gray500, renderingMode: .alwaysOriginal)
    static let upIcon = UIImage(systemName: "chevron.up")?
        .withTintColor(.gray500, renderingMode: .alwaysOriginal)
    static let leftIcon = UIImage(systemName: "chevron.left")?
        .withTintColor(.label, renderingMode: .alwaysOriginal)
    static let rightIcon = UIImage(systemName: "chevron.right")?
        .withTintColor(.label, renderingMode: .alwaysOriginal)
    static let notificationIcon = UIImage(systemName: "bell")?
        .withTintColor(.gray500, renderingMode: .alwaysOriginal)
}

struct ReviewWriters {
    let memberNickname: String
    let memberRole: String
}

struct NonReviewWriters {
    let memberNickname: String
    let memberRole: String
}

struct TeamMemberDataModel {
    let reviewDay: String
    let reviewDate: String
    let reviewWriters: [ReviewWriters]?
    let nonReviewWriters: [NonReviewWriters]?
}

extension TeamMemberDataModel {
    static func dummy() -> [TeamMemberDataModel] {
        return [TeamMemberDataModel(reviewDay: "월요일",
                                        reviewDate: "2023-07-10",
                                        reviewWriters:
//                                        nil,
                                        [ReviewWriters(memberNickname: "닉네임은닉네임최대10자보이게할게요", memberRole: "역할도최대10글자일걸요ㅋㅋㅋ"),
                                                        ReviewWriters(memberNickname: "박솝트", memberRole: "iOS"),
                                                        ReviewWriters(memberNickname: "박솝트", memberRole: "iOS")],
//                                        nonReviewWriters: nil)
                                        nonReviewWriters: [NonReviewWriters(memberNickname: "나지롱", memberRole: "Server")])
               ]
    }
}
