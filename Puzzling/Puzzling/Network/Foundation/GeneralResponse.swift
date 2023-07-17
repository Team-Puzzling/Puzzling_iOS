//
//  GeneralResponse.swift
//  Puzzling-iOS
//
//  Created by KJ on 2023/07/04.
//

import Foundation

struct GeneralResponse<T: Decodable>: Decodable {
    var status: Int
    var success: Bool
    var message: String?
    var data: T?

    enum CodingKeys: String, CodingKey {
        case status
        case success
        case message
        case data
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = (try? values.decode(Int.self, forKey: .status)) ?? 0
        success = (try? values.decode(Bool.self, forKey: .success)) ?? true
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode(T.self, forKey: .data)) ?? nil
    }
}
