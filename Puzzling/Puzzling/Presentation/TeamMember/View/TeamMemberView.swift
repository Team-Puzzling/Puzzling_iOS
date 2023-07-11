//
//  TeamMemberView.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/10.
//


import UIKit

import FSCalendar
import SnapKit
import Then

class TeamMemberView: UIView {
    
    public lazy var calendarView = FSCalendar(frame: .zero)
    
    public lazy var toggleButton = UIButton()
    
    public lazy var headerLabel = UILabel()
    
    private lazy var testLabel = UILabel()
    
    let headerDateFormatter = DateFormatter().then {
        $0.dateFormat = "YYYY년 M월"
        $0.locale = Locale(identifier: "ko_kr")
        $0.timeZone = TimeZone(identifier: "KST")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Custom Method
    
    private func setStyle() {
        
        self.backgroundColor = .white
        
        calendarView.do {
            $0.select(Date())
            
            $0.locale = Locale(identifier: "ko_KR")
            $0.scope = .week
            
            $0.appearance.headerTitleColor = .clear
            $0.appearance.headerMinimumDissolvedAlpha = 0.0
            
            $0.appearance.selectionColor = .blue400
            
            let offset: Double = (self.frame.width - ("YYYY년 M월" as NSString)
                .size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22.0)])
                .width - 16.0 ) / 2.0
            $0.appearance.headerTitleOffset = CGPoint(x: -offset, y: 0)
            
            $0.weekdayHeight = 36.0
            $0.headerHeight = 36.0
            
            $0.appearance.weekdayFont = .systemFont(ofSize: 13)
            $0.appearance.titleFont = .boldSystemFont(ofSize: 15)
            
            $0.appearance.titleTodayColor = .gray400
            $0.appearance.titleDefaultColor = .secondaryLabel
            
            $0.appearance.todayColor = .clear
            $0.appearance.weekdayTextColor = .gray400
            
            $0.placeholderType = .none
            
            $0.scrollEnabled = true
            $0.scrollDirection = .horizontal
        }
        toggleButton.do {
            $0.titleLabel?.font = .systemFont(ofSize: 22.0)
            $0.setImage(Icon.downIcon, for: .normal)
            $0.semanticContentAttribute = .forceRightToLeft
        }
        
        headerLabel.do { [weak self] in
            guard let self = self else { return }
            $0.font = .systemFont(ofSize: 22.0, weight: .bold)
            $0.textColor = .label
            $0.text = self.headerDateFormatter.string(from: Date())
            
        }
        
        //        testLabel.do {
        //            $0.text = "라벨입니다"
        //        }
    }
    
    private func setLayout() {
        self.addSubviews(calendarView, headerLabel, toggleButton)
        
        calendarView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.leading.equalToSuperview().inset(12.0)
            $0.height.equalTo(300)
        }
        
        headerLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(8)
            
        }
        
        toggleButton.snp.makeConstraints {
            $0.centerY.equalTo(headerLabel.snp.centerY)
            $0.leading.equalTo(headerLabel.snp.trailing)
            $0.size.equalTo(36)
        }
        
    }
}
