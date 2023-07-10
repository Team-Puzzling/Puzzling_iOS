//
//  FontLevel.swift
//  Puzzling-iOS
//
//  Created by KJ on 2023/07/04.
//

import Foundation

public enum FontLevel {
    
    // MARK: - Kor
    
    case heading1_kor
    case heading2_kor
    case heading3_kor
    case heading4_kor

    case body1_bold_kor
    case body1_regular_kor
    case body2_bold_kor
    case body2_regular_kor
    case body3_bold_kor
    case body3_regular_kor

    case detail1_bold_kor
    case detail1_regular_kor
    case detail2_bold_kor
    case detail2_regular_kor
    case detail3_regular_kor
    
    // MARK: - Eng
    
    case heading1_eng           // 24pt / bold
    case heading2_eng           // 22pt / bold
    case heading3_eng           // 20pt / bold
    case heading4_eng           // 18pt / bold
    
    case body1_bold_eng         // 16pt / bold
    case body1_regular_eng      // 16pt / regular
    case body2_bold_eng         // 15pt / bold
    case body2_regular_eng      // 15pt / regular
    case body3_bold_eng         // 14pt / bold
    case body3_regular_eng      // 14pt / regular
    
    case detail1_bold_eng       // 13pt / bold
    case detail1_regular_eng    // 13pt / regular
    case detail2_bold_eng       // 12pt / bold
    case detail2_regular_eng    // 12pt / regular
    case detail3_regular_eng    // 11pt / regular
}

extension FontLevel {
    
    public var fontWeight: String {
        switch self {
        case .heading1_kor:
            return AppleSDGothicNeoType.bold.rawValue
        case .heading2_kor:
            return AppleSDGothicNeoType.bold.rawValue
        case .heading3_kor:
            return AppleSDGothicNeoType.bold.rawValue
        case .heading4_kor:
            return AppleSDGothicNeoType.bold.rawValue
        case .body1_bold_kor:
            return AppleSDGothicNeoType.bold.rawValue
        case .body1_regular_kor:
            return AppleSDGothicNeoType.regular.rawValue
        case .body2_bold_kor:
            return AppleSDGothicNeoType.bold.rawValue
        case .body2_regular_kor:
            return AppleSDGothicNeoType.regular.rawValue
        case .body3_bold_kor:
            return AppleSDGothicNeoType.bold.rawValue
        case .body3_regular_kor:
            return AppleSDGothicNeoType.regular.rawValue
        case .detail1_bold_kor:
            return AppleSDGothicNeoType.bold.rawValue
        case .detail1_regular_kor:
            return AppleSDGothicNeoType.regular.rawValue
        case .detail2_bold_kor:
            return AppleSDGothicNeoType.bold.rawValue
        case .detail2_regular_kor:
            return AppleSDGothicNeoType.regular.rawValue
        case .detail3_regular_kor:
            return AppleSDGothicNeoType.regular.rawValue
        case .heading1_eng:
            return SFProType.bold.rawValue
        case .heading2_eng:
            return SFProType.bold.rawValue
        case .heading3_eng:
            return SFProType.bold.rawValue
        case .heading4_eng:
            return SFProType.bold.rawValue
        case .body1_bold_eng:
            return SFProType.bold.rawValue
        case .body1_regular_eng:
            return SFProType.regular.rawValue
        case .body2_bold_eng:
            return SFProType.bold.rawValue
        case .body2_regular_eng:
            return SFProType.regular.rawValue
        case .body3_bold_eng:
            return SFProType.bold.rawValue
        case .body3_regular_eng:
            return SFProType.regular.rawValue
        case .detail1_bold_eng:
            return SFProType.bold.rawValue
        case .detail1_regular_eng:
            return SFProType.regular.rawValue
        case .detail2_bold_eng:
            return SFProType.bold.rawValue
        case .detail2_regular_eng:
            return SFProType.regular.rawValue
        case .detail3_regular_eng:
            return SFProType.regular.rawValue
        }
    }
    
    public var fontSize: CGFloat {
        switch self {
        case .heading1_kor:
            return 24
        case .heading2_kor:
            return 22
        case .heading3_kor:
            return 20
        case .heading4_kor:
            return 18
        case .body1_bold_kor:
            return 16
        case .body1_regular_kor:
            return 16
        case .body2_bold_kor:
            return 15
        case .body2_regular_kor:
            return 15
        case .body3_bold_kor:
            return 14
        case .body3_regular_kor:
            return 14
        case .detail1_bold_kor:
            return 13
        case .detail1_regular_kor:
            return 13
        case .detail2_bold_kor:
            return 12
        case .detail2_regular_kor:
            return 12
        case .detail3_regular_kor:
            return 11
        case .heading1_eng:
            return 24
        case .heading2_eng:
            return 22
        case .heading3_eng:
            return 20
        case .heading4_eng:
            return 18
        case .body1_bold_eng:
            return 16
        case .body1_regular_eng:
            return 16
        case .body2_bold_eng:
            return 15
        case .body2_regular_eng:
            return 15
        case .body3_bold_eng:
            return 14
        case .body3_regular_eng:
            return 14
        case .detail1_bold_eng:
            return 13
        case .detail1_regular_eng:
            return 13
        case .detail2_bold_eng:
            return 12
        case .detail2_regular_eng:
            return 12
        case .detail3_regular_eng:
            return 11
        }
    }
}
