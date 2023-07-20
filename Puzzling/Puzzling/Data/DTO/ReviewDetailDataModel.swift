//
//  ReviewDetailDataModel.swift
//  Puzzling
//
//  Created by Kim Min Joo on 2023/07/15.
//
//
//import Foundation
//
//// didSelect 해당 날짜를 기준으로 filter
//// 없으면 엠티뷰, 있으면 그대로 가져오면 댐
//
//struct ReviewDetailDataModel {
//    let reviewId: Int?
//    let reviewDay: String
//    let reviewDate: String
//    let contents: [Contents]?
//}
//
//struct Contents {
//    let title: String
//    let content: String
//}
//
//extension ReviewDetailDataModel {
//    static func dummy() -> [ReviewDetailDataModel] {
//        return [ReviewDetailDataModel(reviewId: nil,
//                                      reviewDay: "월",
//                                      reviewDate: "2023-07-10",
//                                      contents: nil),
//                ReviewDetailDataModel(reviewId: 1,
//                                      reviewDay: "수",
//                                      reviewDate: "2023-07-12",
//                                      contents: [Contents(title: "잘한 점",
//                                                          content: "2023-07-12 데이터지롱 ㅋㅋㅋㅋ placeholder 위치, 텍스트박스는텍스트박스는 이 사이즈가 기본 사이즈입니다. 양 옆 마진 16px을 가진 텍스트박스가 존재합니다. 회고를 길게길게 작성하여 내용이재합니다. 회고를 길게길게 작성하여 내용이 더욱 길어지면회고를 길게길게 작성하여 내용이재합니다. 회고를 길게길게 작성하여 내용이 더욱 길어지면회고를 길게길게 작성하여 내용이재합니다. 회고를 길게길게 작성하여 내용이 더욱 길어지면회고를 길게길게 작성하여 내용이재합니다. 회고를 길게길게 작성하여 내용이 더욱 길어지면 다음과 같이 작성한 회고고 길어지고 빙빙 돌아가는 회전목마처럼 어쩌고 저쩌고 끝 끝 끝"),
//                                                 Contents(title: "아쉬운 점",
//                                                          content: "placeh회고를 길게길게 작성하여 내용이재합니다. 회고를 길게길게 작성하여 내용이 더욱 길어지면회고를 길게길게 작성하여 내용이재합니다. 회고를 길게길게 작성하여 내용이 더욱 길어지면회고를 길게길게 작성하여 내용이재합니다. 회고를 길게길게 작성하여 내용이 더욱 회고를 길게길게 작성하여 내용이재합니다. 회고를 길게길게 작성하여 내용이 더욱 길어지면회고를 길게길게 작성하여 내용이재합니다. 회고를 길게길게 작성하여 내용이 더욱 길어지면회고를 길게길게 작성하여 내용이재합니다. 회고를 길게길게 작성하여 내용이 더욱 길어지면회고를 길게길게 작성하여 내용이재합니다. 회고를 길게길게 작성하여 내용이 더욱 길어지면길어지면회고를 길게길게 작성하여 내용이재합니다. 회고를 길게길게 작성하여 내용이 더욱 길어지면old. 양 옆 마진 16px을 가진 텍스트박스가 존재합니다마처럼 어쩌고 저쩌고 끝 끝 끝"),
//                                                 Contents(title: "배운 점",
//                                                          content: "placeholder 위치, 텍회고를 길게길게 작성하여 내용이재합니다. 회고를 길게길게 작성하여 내용이 더욱 길어지면회고를 길게길게 작성하여 내용이재합니다. 회고를 길게길게 작성하여 내용이 더욱 길어지면회고를 길게길게 작성하여 내용이재합니다. 회고를 길게길게 작성하여 내용이 더욱 길어지면회고를 길게길게 작성하여 내용이재합니다. 회고를 길게길게 작성하여 내용이 더욱 길어지면스트박스는 이 사이즈가 기본 사이즈입니다. 양 옆 마진 16px을 가 작성한 회고 길이에 맞게 길어지게 됩니다. 길어지고 길어지고 길어지고 길어지고 빙빙 돌아가는 회전목마처럼 어쩌고 저쩌고 끝 끝 끝")]),
//                ReviewDetailDataModel(reviewId: 2,
//                                      reviewDay: "금",
//                                      reviewDate: "2023-07-14",
//                                      contents: [Contents(title: "잘한 점",
//                                                          content: "2023-07-14 데이터지롱 ㅋㅋㅋㅋㅋ placeholder 위치, 텍스트박스는텍스트박스는 이 사이즈가 기본 사이즈입니다. 양 옆 마진 16px을 가진 텍스트박스가 존재합니다. 회고를 길게길게 작성하여 내용이재합니다. 회고를 길게길게 작성하여 내용이 더욱 길어지면 다음과 같이 작성한 회고고 길어지고 빙빙 돌아가는 회전목마처럼 어쩌고 저쩌고 끝 끝 끝"),
//                                                 Contents(title: "아쉬운 점",
//                                                          content: "placehold. 양 옆 마진 16px을 가진 텍스트박스가 존재합니다마처럼 어쩌고 저쩌고 끝 끝 끝"),
//                                                 Contents(title: "배운 점",
//                                                          content: "placeholder 위치, 텍스트박스는 이 사이즈가 기본 사이즈입니다. 양 옆 마진 16px을 가 작성한 회고 길이에 맞게 길어지게 됩니다. 길어지고 길어지고 길어지고 길어지고 빙빙 돌아가는 회전목마처럼 어쩌고 저쩌고 끝 끝 끝")]),
//                ReviewDetailDataModel(reviewId: 3,
//                                      reviewDay: "월",
//                                      reviewDate: "2023-07-17",
//                                      contents: [Contents(title: "잘한 점",
//                                                          content: "2023-07-17 데이터지롱 ㅋㅋㅋㅋㅋ placeholder 위치, 텍스트박스는텍스트박스는 이 사이즈가 기본 사이즈입니다. 양 옆 마진 16px을 가진 텍스트박스가 존재합니다. 회고를 길게길게 작성하여 내용이재합니다. 회고를 길게길게 작성하여 내용이 더욱 길어지면 다음과 같이 작성한 회고고 길어지고 빙빙 돌아가는 회전목마처럼 어쩌고 저쩌고 끝 끝 끝"),
//                                                 Contents(title: "아쉬운 점",
//                                                          content: "placehold. 양 옆 마진 16px을 가진 텍스트박스가 존재합니다마처럼 어쩌고 저쩌고 끝 끝 끝"),
//                                                 Contents(title: "배운 점",
//                                                          content: "placeholder 위치, 텍스트박스는 이 사이즈가 기본 사이즈입니다. 양 옆 마진 16px을 가 작성한 회고 길이에 맞게 길어지게 됩니다. 길어지고 길어지고 길어지고 길어지고 빙빙 돌아가는 회전목마처럼 어쩌고 저쩌고 끝 끝 끝")])
//        ]
//    }
//}
