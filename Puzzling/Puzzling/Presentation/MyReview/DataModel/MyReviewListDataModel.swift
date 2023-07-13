//
//  MyReviewListDataModel.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/13.
//


struct MyReviewListDataModel {
    let reviewId: Int
    let reviewDate: String
    let contents: String
}

extension MyReviewListDataModel {
    static func dummy() -> [MyReviewListDataModel] {
        return [MyReviewListDataModel(reviewId: 1,
                                      reviewDate: "2023-07-02",
                                      contents: "여기는 20글자 정도 노출되고,,"),
                MyReviewListDataModel(reviewId: 2,
                                      reviewDate: "2023-07-03",
                                      contents: "유저가 회고 템플릿에서 가장 첫 번째 인풋창에 입력한 값 노출.. "),
                MyReviewListDataModel(reviewId: 3,
                                      reviewDate: "2023-07-04",
                                      contents: "유저가 회고 템플릿에서 가장 첫 번째 인풋창에 입력한 값 노출.. "),
                MyReviewListDataModel(reviewId: 4,
                                      reviewDate: "2023-07-05",
                                      contents: "유저가 회고 템플릿에서 가장 첫 번째 인풋창에 입력한 값 노출.. "),
                MyReviewListDataModel(reviewId: 5,
                                      reviewDate: "2023-07-06",
                                      contents: "유저가 회고 템플릿에서 가장 첫 번째 인풋창에 입력한 값 노출.. "),
                MyReviewListDataModel(reviewId: 6,
                                      reviewDate: "2023-07-07",
                                      contents: "유저가 회고 템플릿에서 가장 첫 번째 인풋창에 입력한 값 노출.. "),
                MyReviewListDataModel(reviewId: 7,
                                      reviewDate: "2023-07-08",
                                      contents: "유저가 회고 템플릿에서 가장 첫 번째 인풋창에 입력한 값 노출.. "),
                MyReviewListDataModel(reviewId: 8,
                                      reviewDate: "2023-07-09",
                                      contents: "유저가 회고 템플릿에서 가장 첫 번째 인풋창에 입력한 값 노출.. "),
                MyReviewListDataModel(reviewId: 9,
                                      reviewDate: "2023-07-10",
                                      contents: "유저가 회고 템플릿에서 가장 첫 번째 인풋창에 입력한 값 노출.. "),
                MyReviewListDataModel(reviewId: 10,
                                      reviewDate: "2023-07-11",
                                      contents: "유저가 회고 템플릿에서 가장 첫 번째 인풋창에 입력한 값 노출.. ")]
    }
}
