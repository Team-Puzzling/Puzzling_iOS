//
//  TeamMemberCalendarView.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/19.
//

import UIKit

import FSCalendar
import SnapKit
import Then
import Moya

final class TeamMemberCalendarView: UIView {
    
    // MARK: - UI Components
    
    private lazy var calendarView = FSCalendar(frame: .zero)
    private lazy var headerLabel = UILabel()
    private lazy var testLabel = UILabel()
    
    // MARK: - Properties
    
    private var calendarViewHeight = NSLayoutConstraint()
    private var selectedDate: String = ""
    private let dateFormatter = DateFormatter()
    private var teamMemberList: [TeamMemberModel] = [TeamMemberModel(reviewDay: "", reviewDate: "", reviewWriters: nil, nonReviewWriters: nil)]
    private let headerDateFormatter = DateFormatter().then {
        $0.dateFormat = "YYYY년 M월"
        $0.locale = Locale(identifier: "ko_kr")
        $0.timeZone = TimeZone(identifier: "KST")
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
        setDelegate()
        setDateFormatter()
        setNotificationCenter()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("listNotification"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("dateNotification"), object: nil)
        print(className)
    }
}

extension TeamMemberCalendarView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        calendarView.do {
            
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
            $0.today = nil
        }
        
        headerLabel.do {
            $0.font = .fontGuide(.heading2_kor)
            $0.textColor = .black000
            $0.text = self.headerDateFormatter.string(from: Date())
        }
        
        calendarViewHeight.constant = 350
    }
    
    private func setLayout() {
        
        // MARK: - Layout Helper
        
        self.addSubviews(calendarView, headerLabel)
        
        calendarView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.leading.equalToSuperview().inset(8)
        }
    }
    
    // MARK: - Methods
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(getDateNotification(_:)), name: Notification.Name("dateNotification"), object: nil)
    }
    
    private func setDateFormatter(){
        dateFormatter.do {
            $0.dateFormat = "yyyy-MM-dd"
            $0.locale = Locale(identifier: "ko_kr")
            $0.timeZone = TimeZone(identifier: "KST")
        }
    }
}

extension TeamMemberCalendarView {
    
    // MARK: - @objc Methods
    
    @objc
    private func getListNotification(_ notification: Notification) {
        let listNotification = notification.userInfo?["userInfo"]
        teamMemberList = listNotification as! [TeamMemberModel]
        calendarView.reloadData()
    }
    
    @objc
    private func getDateNotification(_ notification: Notification) {
        let dateNotification = notification.userInfo?["userInfo"]
        selectedDate = dateNotification as! String
        calendarView.select(dateFormatter.date(from: selectedDate))
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
        sendDateNotification(string: dateFormatter.string(from: date))
    }
}

extension TeamMemberCalendarView {
    
    func getCalendarViewHeight() -> CGFloat{
        return self.calendarViewHeight.constant
    }
}
