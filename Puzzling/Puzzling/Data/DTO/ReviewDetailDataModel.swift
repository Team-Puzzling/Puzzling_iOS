//
//  ReviewDetailDataModel.swift
//  Puzzling
//
//  Created by Kim Min Joo on 2023/07/15.
//

import Foundation

struct ReviewDetailDataModel {
    let reviewId: Int?
    let reviewDay: String
    let reviewDate: String
    let contents: [Contents]?
}

struct Contents {
    let title: String
    let content: String
}

extension ReviewDetailDataModel {
    static func dummy() -> [ReviewDetailDataModel] {
        return [ReviewDetailDataModel(reviewId: nil,
                                      reviewDay: "월",
                                      reviewDate: "2023-07-10",
                                      contents: nil),
                ReviewDetailDataModel(reviewId: 2,
                                      reviewDay: "화",
                                      reviewDate: "2023-07-04",
                                      contents: [Contents(title: "잘한 점",
                                                          content: "placeholder 위치, 텍스트박스는텍스트박스는 이 사이즈가 기본 사이즈입니다. 양 옆 마진 16px을 가진 텍스트박스가 존재합니다. 회고를 길게길게 작성하여 내용이 더욱 길어지면 다음과 같이 작성한 회고 길이에 맞게 길어지게 스가 존재합니다. 회고를 길게길게 작성하여 내용이 더욱 길어지면 다음과 같이 작성한 회고 길이에 맞게 길어지게 스가 존재합니다. 회고를 길게길게 작성하여 내용이 더욱 길어지면 다음과 같이 작성한 회고 길이에 맞게 길어지게 됩니다. 길어지고 길어지고 길어지고 길어지고 빙빙 돌아가는 회전목마처럼 어쩌고 저쩌고"),
                                                 Contents(title: "아쉬운 점",
                                                          content: "placeholder 위치, 텍스트박스는 이 사이즈가 기본 사이즈입니다. 양 옆 마진 16px을 가진 텍스트박스가 존재합니다. 회고를 der 위치, 텍스트박스는 이 사이즈가 기본 사이즈입니다. 양 옆 마진 16px을 가진 텍스트박스가 존재합니다. 회고를 der 위치, 텍스트박스는 이 사이즈가 기본 사이즈입니다. 양 옆 마진 16px을 가진 텍스트박스가 존재합니다. 회고를 der 위회고 길이에 맞게 길어지게 됩니다. 길어지고 길어지고 길어지고 길어지고 빙빙 돌아가는 회전목마처럼 어쩌고 저쩌고"),
                                                 Contents(title: "배운 점",
                                                          content: "placeholder 위치, 텍스트박스는 이 사이즈가 기본 사이즈입니다. 양 옆 마진 16px을 가진 텍스트박스가 존재합니다. 회고를 길게길게 작성하여 내용이 더욱 길어지면 다음과 같이 작성한 회고 길이에 맞게 길어지게 됩니다. 길어지고 길어지고 길어지고 길어지고 빙빙 돌아가는 회전목마처럼 어쩌고 텍스트박스는 이 사이즈가 기본 사이즈입니다. 양 옆 마진 16px을 가진 텍스트박스가 존재합니다. 회고를 길게길게 작성하여 내용이 더욱 길어지면 다음과 같이 작성한 회고 길이에 맞게 길어지게 됩니다. 길어지고 길어지고 길어지고 길어지고 빙빙 돌아가는 회전목마처럼 어쩌고 텍스트박스는 이 사이즈가 기본 사이즈입니다. 양 옆 마진 16px을 가진 텍스트박스가 존재합니다. 회고를 길게길게 작성하여 내용이 더욱 길어지면 다음과 같이 작성한 회고 길이에 맞게 길어지게 됩니다. 길어지고 길어지고 길어지고 길어지고 빙빙 돌아가는 회전목마처럼 어쩌고 텍스트박스는 이 사이즈가 기본 사이즈입니다. 양 옆 마진 16px을 가진 텍스트박스가 존재합니다. 회고를 길게길게 작성하여 내용이 더욱 길어지면 다음과 같이 작성한 회고 길이에 맞게 길어지게 됩니다. 길어지고 길어지고 길어지고 길어지고 빙빙 돌아가는 회전목마처럼 어쩌고 저쩌고")])
        ]
    }
}
