//
//  Date+.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/18.
//

import Foundation

extension Date {
    /// Date 를 "yyyy-MM-dd" 형식으로 반환합니다.
    var dateToServerString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(identifier: "KST")
        let result = dateFormatter.string(from: self)
        return result
    }
    
    /// Date 를 월, 화, 수 같은 요일로 반환합니다.
    var dateToDayString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEEEE"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(identifier: "KST")
        let dayString = dateFormatter.string(from: self)
        return dayString
    }
}
