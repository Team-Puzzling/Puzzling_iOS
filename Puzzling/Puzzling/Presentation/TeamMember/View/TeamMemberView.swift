//
//  TeamMemberView.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/17.
//

import UIKit

import FSCalendar
import SnapKit
import Then
import Moya

final class TeamMemberCalendarView: UIView {
    
    private lazy var calendarView = FSCalendar(frame: .zero)
    private var calendarViewHeight = NSLayoutConstraint()
    private lazy var headerLabel = UILabel()
    private lazy var testLabel = UILabel()
    
    private let dateFormatter = DateFormatter().then {
        $0.dateFormat = "yyyy-MM-dd"
        $0.locale = Locale(identifier: "ko_kr")
        $0.timeZone = TimeZone(identifier: "KST")
    }
    private var teamMemberList: [TeamMemberModel] = [TeamMemberModel(reviewDay: "", reviewDate: "", reviewWriters: nil, nonReviewWriters: nil)]

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
        setNotificationCenter()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TeamMemberCalendarView {
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
    
    private func setNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(getListNotification(_:)), name: Notification.Name("listNotification"), object: nil)
        
    }
}

extension TeamMemberCalendarView {
    @objc
    private func getListNotification(_ notification: Notification) {
        let listNotification = notification.userInfo?["userInfo"]
        teamMemberList = listNotification as! [TeamMemberModel]
//        teamMemberTableView.reloadData()
    }
}

extension TeamMemberCalendarView: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let currentPage = calendarView.currentPage
        headerLabel.text = headerDateFormatter.string(from: currentPage)
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.frame = CGRect(origin: calendar.frame.origin , size: bounds.size)
        self.calendarViewHeight.constant = bounds.height
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        var boolData: Bool = false
        teamMemberList.forEach {
            if(date == dateFormatter.date(from: $0.reviewDate)) {
                boolData = true
            }
        }
        return boolData
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        var colorData: UIColor = .clear
        teamMemberList.forEach {
            if(date == dateFormatter.date(from: $0.reviewDate) && $0.reviewWriters != nil) {
                colorData = .blue100
            }
        }
        return colorData
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        var colorData: UIColor = .gray400
        teamMemberList.forEach {
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
//        sendDateBoolNotification(bool: true)
        sendDateNotification(string: dateFormatter.string(from: date))
//        teamMemberData.forEach {
//            let modelDate = dateFormatter.date(from: $0.reviewDate)
//            if(date == modelDate && $0.reviewWriters == nil) {
//                sendDateBoolNotification(bool: false)
//            }
//        }
    }
}

extension TeamMemberCalendarView {
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
