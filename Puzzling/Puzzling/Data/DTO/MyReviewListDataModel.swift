//
//  MyReviewListDataModel.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/14.
//

struct MyReviewListDataModel {
    let reviewId: Int
    let reviewDate: String
    let contents: String
}

extension MyReviewListDataModel {
    static func dummy() -> [MyReviewListDataModel] {
        return [MyReviewListDataModel(reviewId: 1,
                                      reviewDate: "2023-07-10",
                                      contents: "여기는 20글자 정도 노출되고,,"),
                MyReviewListDataModel(reviewId: 2,
                                      reviewDate: "2023-07-12",
                                      contents: "유저가 회고 템플릿에서 가장 첫 번째 인풋창에 입력한 값 노출.. "),
                MyReviewListDataModel(reviewId: 3,
                                      reviewDate: "2023-07-14",
                                      contents: "유저가 회고 템플릿에서 가장 첫 번째 인풋창에 입력한 값 노출.. "),
                MyReviewListDataModel(reviewId: 4,
                                      reviewDate: "2023-07-17",
                                      contents: "유저가 회고 템플릿에서 가장 첫 번째 인풋창에 입력한 값 노출.. ")]
    }
}
