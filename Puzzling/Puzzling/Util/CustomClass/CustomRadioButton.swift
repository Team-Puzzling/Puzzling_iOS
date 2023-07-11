//
//  UIRadioButton.swift
//  Puzzling
//
//  Created by 천성우 on 2023/07/11.
//

import UIKit

class CustomRadioButton: UIButton {
    
    var btnSelected: Bool = false
    
    // MARK: - UI Components
    
    private let innerCircle = UIView()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButton()
        setInnerCircle()
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setButton()
        setInnerCircle()
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    private func setButton() {
        self.layer.cornerRadius = 8.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.gray200.cgColor
    }
    
    private func setInnerCircle() {
        let circleSize = CGSize(width: 10.0, height: 10.0)
        let circlePoint = CGPoint(
            x: (self.bounds.width - circleSize.width) / 2,
            y: (self.bounds.height - circleSize.height) / 2
        )
        let circleFrame = CGRect(origin: circlePoint, size: circleSize)
        
        innerCircle.frame = circleFrame
        innerCircle.layer.cornerRadius = circleSize.width / 2
        innerCircle.backgroundColor = UIColor.blue400
        innerCircle.isUserInteractionEnabled = false
        innerCircle.isHidden = true
        
        self.addSubview(innerCircle)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let circleSize = CGSize(width: 10.0, height: 10.0)
        let circlePoint = CGPoint(
            x: (self.bounds.width - circleSize.width) / 2,
            y: (self.bounds.height - circleSize.height) / 2
        )
        let circleFrame = CGRect(origin: circlePoint, size: circleSize)
        
        innerCircle.frame = circleFrame
        innerCircle.layer.cornerRadius = circleSize.width / 2
    }
    
    // MARK: - @objc Methods
    
    @objc private func buttonTapped() {
        innerCircle.isHidden = !innerCircle.isHidden
        btnSelected = !innerCircle.isHidden
        print(btnSelected)
    }
}
