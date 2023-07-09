//
//  Color.swift
//  Puzzling-iOS
//
//  Created by KJ on 2023/07/04.
//

import UIKit

extension UIColor {
    
    /// Color Picker 에서 UIColor 를 고르면 Hex String 으로 변환한다.
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return String(format:"#%06x", rgb)
    }
    
    /// Hex Code 를 입력하면 UIColor 로 반환한다.
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: alpha)
    }
}

public enum Color {
    
    // MARK: - Achromatic Color
    
    public static let black = UIColor(named: "black-000")!
    public static let gray1 = UIColor(named: "gray-100")!
    public static let gray2 = UIColor(named: "gray-200")!
    public static let gray3 = UIColor(named: "gray-300")!
    public static let gray4 = UIColor(named: "gray-400")!
    public static let gray5 = UIColor(named: "gray-500")!
    public static let gray6 = UIColor(named: "gray-600")!
    public static let gray7 = UIColor(named: "gray-700")!
    public static let white = UIColor(named: "white-000")!
    
    // MARK: - Background Color
    
    public static let bg050 = UIColor(named: "bg-050")!
    public static let bg500 = UIColor(named: "bg-500")!
    
    // MARK: - Main Blue
    
    public static let blue7 = UIColor(named: "blue-700")!
    public static let blue6 = UIColor(named: "blue-600")!
    public static let blue5 = UIColor(named: "blue-500")!
    public static let blue4 = UIColor(named: "blue-400")!
    public static let blue3 = UIColor(named: "blue-300")!
    public static let blue2 = UIColor(named: "blue-200")!
    public static let blue1 = UIColor(named: "blue-100")!
    
    // MARK: - Main Yellow
    
    public static let yellow5 = UIColor(named: "yellow-500")!
    public static let yellow4 = UIColor(named: "yellow-400")!
    public static let yellow2 = UIColor(named: "yellow-200")!
    public static let yellow1 = UIColor(named: "yellow-100")!
    
    // MARK: - Warning Red
    
    public static let red6 = UIColor(named: "red-600")!
    public static let red4 = UIColor(named: "red-400")!
    public static let red2 = UIColor(named: "red-200")!
}
