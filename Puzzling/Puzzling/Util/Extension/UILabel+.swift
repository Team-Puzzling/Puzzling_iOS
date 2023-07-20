//
//  UILabel+.swift
//  Puzzling-iOS
//
//  Created by KJ on 2023/07/04.
//

import UIKit

extension UILabel {
    func partColorChange(targetString: String, textColor: UIColor) {
        let fullText = self.text ?? ""
        let range = (fullText as NSString).range(of: targetString)
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.foregroundColor, value: textColor, range: range)
        self.attributedText = attributedString
    }
    
    func asColor(targetString: String, color: UIColor) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        attributedString.addAttribute(.foregroundColor, value: color, range: range)
        attributedText = attributedString
    }
    
    func setLineSpacing(spacing: CGFloat) {
        guard let text = text else { return }
        
        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        attributeString.addAttribute(.paragraphStyle,
                                     value: style,
                                     range: NSRange(location: 0, length: attributeString.length))
        attributedText = attributeString
    }
    
    func lineHeightMultiple(spacing: CGFloat) {
        guard let text = text else { return }
        
        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        style.alignment = .center
        style.lineHeightMultiple = 1.25
        attributeString.addAttribute(.paragraphStyle,
                                     value: style,
                                     range: NSRange(location: 0, length: attributeString.length))
        attributedText = attributeString
    }
    
    func addCharacterSpacing(kernValue:Double = -0.5) {
        guard let text = text, !text.isEmpty else { return }
        let string = NSMutableAttributedString(string: text)
        string.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: string.length - 1))
        attributedText = string
    }
}
