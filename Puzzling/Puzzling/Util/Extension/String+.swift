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
    
    func size(OfFont font: UIFont) -> CGSize {
        let size = (self as NSString).size(withAttributes: [.font: font])
        let buffer = 0.2
        return CGSize(width: size.width + buffer, height: size.height)
    }
    
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
    
    /// text의 높이 값을 리턴합니다. Font는 body2_regular_kor로 지정되어 있습니다.
    func textHeight(withWidth width: CGFloat) -> CGFloat {
        let text = self
         return text.height(withWidth:width, font: UIFont.fontGuide(.body2_regular_kor))
     }
    
    func height(withWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
}
