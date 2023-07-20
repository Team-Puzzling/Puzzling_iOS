//
//  ReviewDetailModel.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/20.
//

import Foundation

struct ReviewDetailModel {
    let reviewId: Int?
    let reviewDay: String
    let reviewDate: String
    let reviewTemplateId: Int?
    let contents: [Contents]?
}
