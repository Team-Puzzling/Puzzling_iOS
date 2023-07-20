//
//  String+.swift
//  Puzzling-iOS
//
//  Created by KJ on 2023/07/04.
//

import UIKit

extension String {
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isOnlyKorean() -> Bool {
        let pattern = "[가-힣]"
        guard self.range(of: pattern, options: .regularExpression) != nil else { return false }
        return true
    }

    func isOnlyKorEngSpe() -> Bool {
        let pattern = "^[0-9a-zA-Z가-힣ㄱ-ㅎㅏ-ㅣ\\s~`!@#$%^&*()-_=+\\\\\\|\\[{\\]};:'\",<.>/?]{0,}$"
        guard self.range(of: pattern, options: .regularExpression) != nil else { return false }
        return true
    }
    
    func size(OfFont font: UIFont) -> CGSize {
        let size = (self as NSString).size(withAttributes: [.font: font])
        let buffer = 0.2
        return CGSize(width: size.width + buffer, height: size.height)
    }
    
    
    
    func isOnlyKorEng() -> Bool {
        let pattern = "^[0-9a-zA-Z가-힣ㄱ-ㅎㅏ-ㅣ\\s]{0,}$"
        guard self.range(of: pattern, options: .regularExpression) != nil else { return false }
        return true
    }
    
    /// "yyyy-MM-dd" 형식의 String 을 "M월 d일" 형식으로 리턴합니다.
    func convertDateToKoreanDateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "M월 d일"
        
        let convertDate = dateFormatter.date(from: self)
        guard let convertedDate = convertDate else { return "" }
        
        let modifiedDateString = myDateFormatter.string(from: convertedDate)
        return modifiedDateString
    }
    
    /// text의 높이 값을 리턴합니다. Font는 body2_regular_kor로 지정되어 있습니다.
    func textHeight(withWidth width: CGFloat) -> CGFloat {
        let text = self
         return text.height(withWidth:width, font: UIFont.fontGuide(.body2_regular_kor))
     }
    /// "yyyy-MM-dd" 형식의 String 을 "M/d" 형식으로 리턴합니다.
    func convertDateToSlashFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "MM/dd"
        
        let convertDate = dateFormatter.date(from: self)
        guard let convertedDate = convertDate else { return "" }
        
        let modifiedDateString = myDateFormatter.string(from: convertedDate)
        return modifiedDateString
    }
    
    func height(withWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    
    /// "yyyy-MM-dd" 형식의 String 을 Date 형식으로 리턴합니다.
    func convertStringToDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let convertDate = dateFormatter.date(from: self)
        guard let convertedDate = convertDate else {
            print("Failed to convert String to Data")
            return Date()
        }
        return convertedDate
        
        /// "yyyy-MM-dd" 형식의 String을 Date 형식으로 리턴합니다.
        func toDate() -> Date? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.timeZone = TimeZone(identifier: "KST")
            if let date = dateFormatter.date(from: self) {
                return date
            } else {
                return nil
            }
        }
    }
}
