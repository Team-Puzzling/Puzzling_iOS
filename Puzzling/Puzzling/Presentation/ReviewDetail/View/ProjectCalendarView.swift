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
import Moya

protocol reviewDateProtocol: AnyObject {
    func reviewDate(reviewDetailModel: ReviewDetailModel)
}

final class ProjectCalendarView: UIView {
    
    weak var delegate: reviewDateProtocol?
    
    private var startDate: String = "2023-04-01"
    private var endDate: String = "2023-12-13"
    
    private var selectedDate: String = "2023-07-14"
    
    private var specificData = ReviewDetailModel(reviewId: nil, reviewDay: "", reviewDate: "", reviewTemplateId: nil, contents: nil)
    
    private var dataList: [ReviewDetailModel] = []
    
    private func findData(date: String) -> ReviewDetailModel? {
        var data = ReviewDetailModel(reviewId: nil, reviewDay: "", reviewDate: "", reviewTemplateId: nil, contents: nil)
        reviewDetailDataModel.forEach {
            if($0.reviewDate == date){
                data = $0
            }
        }
//        let filteredData =  dataList.filter {
//            $0.reviewDate == date
//        }.first
        
        return data
    }
    
    lazy var calendarView = FSCalendar(frame: .zero)
    private var calendarViewHeight = NSLayoutConstraint()
    private lazy var headerLabel = UILabel()
    private lazy var testLabel = UILabel()
    
    private let dateFormatter = DateFormatter()
    
    private let reviewDetailProvider = MoyaProvider<MyProjectService>(plugins:[NetworkLoggerPlugin()])
    
    private var reviewDetailDataModel: [ReviewDetailModel] = []
    
    private let headerDateFormatter = DateFormatter()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
        setDelegate()
        setDateFormatter()
        fetchReviewDetail()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension ProjectCalendarView {
    private func setUI() {
        calendarView.do {
            $0.select(dateFormatter.date(from: selectedDate))
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
            let dateformat = DateFormatter()
            dateformat.dateFormat = "yyyy-MM-dd"
            dateformat.locale = Locale(identifier: "ko_KR")
            dateformat.timeZone = TimeZone(identifier: "KST")
            guard let yyyymmDate = dateformat.date(from: self.selectedDate) else { return }
            $0.textColor = .black000
            $0.text = self.headerDateFormatter.string(from: yyyymmDate)
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
//
//    private func sendDateBoolNotification(bool: Bool) {
//        let userInfo = bool
//        NotificationCenter.default.post(
//            name: Notification.Name("dateBoolNotification"),
//            object: nil,
//            userInfo: ["userInfo": userInfo]
//        )
//    }
//
    private func sendDateNotification(string: String) {
        let userInfo = string
        NotificationCenter.default.post(
            name: Notification.Name("dateNotification"),
            object: nil,
            userInfo: ["userInfo": userInfo]
        )
    }
    
    private func calendarToView() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(sendDataToView2),
                                               name: NSNotification.Name("calendarToView"),
                                               object: nil)
    }
    
    private func setDateFormatter() {
        headerDateFormatter.do {
            $0.dateFormat = "YYYY년 M월"
            $0.locale = Locale(identifier: "ko_KR")
            $0.timeZone = TimeZone(identifier: "KST")
        }
        
        dateFormatter.do {
            $0.locale = Locale(identifier: "ko_KR")
            $0.timeZone = TimeZone(abbreviation: "KST")
            $0.dateFormat = "yyyy-MM-dd"
        }
    }
}

extension ProjectCalendarView {
    @objc func sendDataToView2() {
        NotificationCenter.default.post(name: NSNotification.Name("calendarToView"), object: specificData)
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
        
        let returnDate = dateFormatter.string(from: date)
        guard let model = self.findData(date: returnDate) else { return }
        self.delegate?.reviewDate(reviewDetailModel: model)
        headerLabel.text = headerDateFormatter.string(from: date)
    }
}

extension ProjectCalendarView {
    
    func getCalendarViewHeight() -> CGFloat{
        return self.calendarViewHeight.constant
    }
    
    func selectDate(date: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(identifier: "KST")
        selectedDate = date
        calendarView.select(dateFormatter.date(from: date))
        let currentPage = calendarView.currentPage
        headerLabel.text = headerDateFormatter.string(from: currentPage)
    }
}

extension ProjectCalendarView {
    
    // MARK: - Network
    
    private func fetchReviewDetail() {
        
        guard let memberId = UserDefaults.standard.string(forKey: "memberId") else { return }
        let projectId = "1"
        reviewDetailProvider.request(.reviewDetail(memberId: "1", projectId: "1", startDate: startDate, endDate: endDate)) { result in
            switch result {
            case .success(let result):
                let status = result.statusCode
                print(status)
                if status >= 200 && status < 300 {
                    do {
                        guard let data = try result.map(GeneralResponse<[ReviewDetailResponse]>.self).data else { return }
                        
                        data.forEach {
                            self.reviewDetailDataModel.append($0.convertToReviewDetailModel())
                        }
                        self.calendarToView()
                        self.calendarView.reloadData()
                        self.setUI()
                        let myModel = self.findData(date: self.selectedDate)
                        self.delegate?.reviewDate(reviewDetailModel: myModel ?? ReviewDetailModel(reviewId: nil, reviewDay: "월", reviewDate: "2023-07-17", reviewTemplateId: nil, contents: nil))
                        self.selectDate(date: self.selectedDate)
                        print("♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️")
                        
                    } catch(let error) {
                        print(error.localizedDescription)
                    }
                } else if status == 404 {
                    print("💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
