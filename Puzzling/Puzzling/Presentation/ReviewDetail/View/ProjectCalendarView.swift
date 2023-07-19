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
    
    private lazy var calendarView = FSCalendar(frame: .zero)
    private var calendarViewHeight = NSLayoutConstraint()
    private lazy var headerLabel = UILabel()
    private lazy var testLabel = UILabel()
    
    private let dateFormatter = DateFormatter()
    
    private let reviewDetailDataModel = ReviewDetailDataModel.dummy()
    
    private let headerDateFormatter = DateFormatter()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
        setDelegate()
        setDateFormatter()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProjectCalendarView {
    private func setUI() {
        calendarView.do {
            $0.select(Date())
            print($0.formatter.dateFormat)
//            $0.formatter.timeZone = TimeZone(identifier: "KST")
            $0.formatter.locale = Locale(identifier: "ko_KR")
            
            $0.locale = Locale(identifier: "ko_KR")
            $0.scope = .week
            $0.firstWeekday = 2
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
        calendarViewHeight.constant = 350
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
    
    private func sendDateBoolNotification(bool: Bool) {
        let userInfo = bool
        NotificationCenter.default.post(
            name: Notification.Name("dateBoolNotification"),
            object: nil,
            userInfo: ["userInfo": userInfo]
        )
    }
    
    private func sendDateNotification(string: String) {
        let userInfo = string
        NotificationCenter.default.post(
            name: Notification.Name("dateNotification"),
            object: nil,
            userInfo: ["userInfo": userInfo]
        )
    }
    
    private func setDateFormatter() {
        headerDateFormatter.do {
            $0.dateFormat = "YYYY년 M월"
            $0.locale = Locale(identifier: "ko_KR")
            $0.timeZone = TimeZone(identifier: "KST")
        }
        
        dateFormatter.do {
            $0.dateFormat = "yyyy-MM-dd"
            $0.locale = Locale(identifier: "ko_KR")
            $0.timeZone = TimeZone(identifier: "KST")
        }
    }
}

extension ProjectCalendarView: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let currentPage = calendarView.currentPage
        headerLabel.text = headerDateFormatter.string(from: currentPage)
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.frame = CGRect(origin: calendar.frame.origin , size: bounds.size)
        self.calendarViewHeight.constant = bounds.height
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool
    {
        var boolData: Bool = false
        reviewDetailDataModel.forEach {
            if(date == dateFormatter.date(from: $0.reviewDate)) {
                boolData = true
            }
        }
        return boolData
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        var colorData: UIColor = .clear
        reviewDetailDataModel.forEach {
            if(date == dateFormatter.date(from: $0.reviewDate) && $0.reviewId != nil) {
                colorData = .blue100
            }
        }
        return colorData
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        var colorData: UIColor = .gray400
        reviewDetailDataModel.forEach {
            if(date == dateFormatter.date(from: $0.reviewDate)) {
                colorData = .black000
            }
        }
        return colorData
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleSelectionColorFor date: Date) -> UIColor? {
        return .white000
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        sendDateNotification(string: dateFormatter.string(from: date))
        var boolData: Bool = true
        reviewDetailDataModel.forEach {
            print($0.reviewDate)
            let modelDate = dateFormatter.date(from: $0.reviewDate)
            print(modelDate)
            print("\(String(describing: modelDate))??qqqq????")
            if(date == modelDate && $0.reviewId == nil) {
                boolData = false
                return
            }
        }
        print("dpdpdpdp")
        sendDateBoolNotification(bool: boolData)
    }
}

extension ProjectCalendarView {
    
    func getCalendarViewHeight() -> CGFloat{
        return self.calendarViewHeight.constant
    }
}
