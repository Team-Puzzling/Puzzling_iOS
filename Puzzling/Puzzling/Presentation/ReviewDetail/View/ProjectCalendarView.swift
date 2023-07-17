//
//  ProjectCalendarView.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/15.
//

import UIKit

import FSCalendar
import SnapKit
import Then

final class ProjectCalendarView: UIView {
    
    lazy var calendarView = FSCalendar(frame: .zero)
    var calendarViewHeight = NSLayoutConstraint()
    private lazy var headerLabel = UILabel()
    private lazy var testLabel = UILabel()
    
    private let headerDateFormatter = DateFormatter().then {
        $0.dateFormat = "YYYY년 M월"
        $0.locale = Locale(identifier: "ko_kr")
        $0.timeZone = TimeZone(identifier: "KST")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
        setDelegate()
        calendarViewHeight.constant = 350
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProjectCalendarView {
    private func setUI() {
        calendarView.do {
            $0.select(Date())
            
            $0.locale = Locale(identifier: "ko_KR")
            $0.scope = .week
            
            $0.appearance.selectionColor = .blue400
            
            $0.weekdayHeight = 20
            $0.headerHeight = 62
            
            $0.appearance.weekdayFont = .fontGuide(.detail1_regular_kor)
            $0.appearance.titleFont = .fontGuide(.body2_bold_kor)
            
            $0.appearance.titleDefaultColor = .gray400
            
            $0.appearance.todayColor = .clear
            $0.appearance.titleTodayColor = .gray400
            $0.appearance.weekdayTextColor = .gray400
            
            $0.calendarHeaderView.isHidden = true
            
            $0.scrollEnabled = true
            $0.scrollDirection = .horizontal
        }
        
        headerLabel.do {
            $0.font = .fontGuide(.heading2_kor)
            $0.textColor = .black000
            $0.text = self.headerDateFormatter.string(from: Date())
        }
    }
    
    private func setLayout() {
        self.addSubviews(calendarView, headerLabel)
        
        calendarView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.leading.equalToSuperview().inset(8)
        }
    }
    
    private func setDelegate() {
        calendarView.delegate = self
        calendarView.dataSource = self
    }
}

extension ProjectCalendarView: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let currentPage = calendarView.currentPage
        headerLabel.text = headerDateFormatter.string(from: currentPage)
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.frame = CGRect(origin: calendar.frame.origin , size: bounds.size)
        // Do other updates here
//        calendarView.snp.makeConstraints
        print(bounds.height)
        self.calendarViewHeight.constant = bounds.height
    }
}

extension ProjectCalendarView {
    func setDataBind() {
        calendarView.setScope(.month, animated: true)
        headerDateFormatter.dateFormat = "YYYY년 M월"
        headerLabel.text = headerDateFormatter.string(from: calendarView.currentPage)
    }
    
    func getCalendarViewHeight() -> CGFloat{
        print(self.calendarViewHeight.constant , #function)
        return self.calendarViewHeight.constant
    }
}
