//
//  MyProjectTableViewCell.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/12.
//

import UIKit

import SnapKit
import Then

protocol MyProjectPassEventDelegate: AnyObject {
    func passTouchEvent(projectTitle: String, projectId: Int)
}

final class MyProjectTableViewCell: UITableViewCell {
    
    weak var delegate: MyProjectPassEventDelegate?
    
    private let view = UIView()
    private let projectNameLabel = UILabel()
    private let durationLabel = UILabel()
    private let dashboardButton = UIButton()
    let myReviewButton = UIButton()
    private var projectTitle: String = ""
    private var projectId: Int = 0
    
    private let dateFormatter = DateFormatter().then {
        $0.dateFormat = "yyyy-MM-dd"
        $0.locale = Locale(identifier: "ko_kr")
        $0.timeZone = TimeZone(identifier: "KST")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
        setLayout()
        setAddTarget()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension MyProjectTableViewCell {
    
    private func setUI() {
        
        separatorInset.left = 0
        selectionStyle = .none
        
        view.do {
            $0.makeRounded(radius: 16)
            $0.backgroundColor = .blue100
        }
        
        projectNameLabel.do {
            $0.font = .fontGuide(.body1_bold_kor)
            $0.textColor = .black
        }
        
        durationLabel.do {
            $0.font = .fontGuide(.detail1_regular_kor)
        }
        
        dashboardButton.do {
            $0.setTitle("대시보드 보기", for: .normal)
            $0.setTitleColor(.black000, for: .normal)
            $0.titleLabel?.font = .fontGuide(.body3_bold_kor)
            $0.makeRounded(radius: 16)
            $0.backgroundColor = .white000
        }
        
        myReviewButton.do {
            $0.setTitle("내 회고 모음", for: .normal)
            $0.setTitleColor(.black000, for: .normal)
            $0.titleLabel?.font = .fontGuide(.body3_bold_kor)
            $0.makeRounded(radius: 16)
            $0.backgroundColor = .white000
        }
    }
    
    private func setLayout() {
        contentView.addSubview(view)
        view.addSubviews(projectNameLabel, durationLabel, dashboardButton, myReviewButton)
        
        view.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(12)
        }
        
        projectNameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.top.equalToSuperview().inset(16)
            $0.height.equalTo(24)
        }
        
        durationLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.top.equalToSuperview().inset(18)
        }
        
        dashboardButton.snp.makeConstraints {
            $0.top.equalTo(projectNameLabel.snp.bottom).offset(16)
            $0.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(12)
            $0.width.equalToSuperview().dividedBy(2).inset(9)
        }
        
        myReviewButton.snp.makeConstraints {
            $0.top.equalTo(projectNameLabel.snp.bottom).offset(16)
            $0.width.equalToSuperview().dividedBy(2).inset(9)
            $0.trailing.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview().inset(12)
        }
    }
    
    private func setAddTarget() {
        myReviewButton.addTarget(self, action: #selector(myReviewButtonTapped), for: .touchUpInside)
    }
    
    private func setNotificationCenter(text: String) {
        let userInfo = text
        print(userInfo)
        NotificationCenter.default.post(
            name: Notification.Name("projectNotification"),
            object: nil,
            userInfo: ["userInfo": userInfo]
        )
    }
}

extension MyProjectTableViewCell {
    @objc
    private func myReviewButtonTapped() {
        self.delegate?.passTouchEvent(projectTitle: self.projectTitle, projectId: self.projectId)
    }
}

extension MyProjectTableViewCell {
    private func calculateDays(date: String) -> Int {
        var daysCount: Int = 0
        guard let startDate = dateFormatter.date(from: date) else { return 0 }
        daysCount = days(from: startDate)
        return daysCount
    }
    
    private func days(from date: Date) -> Int {
        let calendar = Calendar.current
        let currentDate = dateFormatter.string(from: Date())
        guard let returnDate = dateFormatter.date(from: currentDate) else { return 0 }
        return (calendar.dateComponents([.day], from: date, to: returnDate).day ?? 0) + 1
    }
}

extension MyProjectTableViewCell {
    func setDataBind(_ data: ProjectListResponse) {
        self.projectTitle = data.projectName
        self.projectId = data.projectId
        
        projectNameLabel.text  = data.projectName
        let duration: Int = calculateDays(date: data.projectStartDate)

        if (duration < 0) {
            durationLabel.text = "D - \((duration - 1) * (-1))"
        }
        
        else if (duration == 0) {
            durationLabel.text = "D - 1"
        }
        
        else {
            durationLabel.text = "D + \(duration)"
        }
    }
}
