//
//  WhoWriteReviewsDataModel.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/10.
//

struct TeamMemberDataModel {
    let reviewDay: String
    let reviewDate: String
    let reviewWriters: [ReviewWriters]?
    let nonReviewWriters: [NonReviewWriters]?
}

struct ReviewWriters {
    let memberNickname: String
    let memberRole: String
}

struct NonReviewWriters {
    let memberNickname: String
    let memberRole: String
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
