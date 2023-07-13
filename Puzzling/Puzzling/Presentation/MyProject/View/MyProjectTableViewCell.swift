//
//  MyProjectTableViewCell.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class MyProjectTableViewCell: UITableViewCell {
    
    private let view = UIView()
    private lazy var projectNameLabel = UILabel()
    private lazy var durationLabel = UILabel()
    private let dashboardLabel = UIButton()
    private let myReviewLabel = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
        setLayout()
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
        
        dashboardLabel.do {
            $0.setTitle("대시보드 보기", for: .normal)
            $0.setTitleColor(.black000, for: .normal)
            $0.titleLabel?.font = .fontGuide(.body3_bold_kor)
            $0.makeRounded(radius: 16)
            $0.backgroundColor = .white000
        }
        
        myReviewLabel.do {
            $0.setTitle("내 회고 모음", for: .normal)
            $0.setTitleColor(.black000, for: .normal)
            $0.titleLabel?.font = .fontGuide(.body3_bold_kor)
            $0.makeRounded(radius: 16)
            $0.backgroundColor = .white000
        }
    }
    
    private func setLayout() {
        contentView.addSubview(view)
        view.addSubviews(projectNameLabel, durationLabel, dashboardLabel, myReviewLabel)
        
        view.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
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
        
        dashboardLabel.snp.makeConstraints {
            $0.top.equalTo(projectNameLabel.snp.bottom).offset(16)
            $0.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(12)
            $0.width.equalToSuperview().dividedBy(2).inset(9)
        }
        
        myReviewLabel.snp.makeConstraints {
            $0.top.equalTo(projectNameLabel.snp.bottom).offset(16)
            $0.width.equalToSuperview().dividedBy(2).inset(9)
            $0.trailing.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview().inset(12)
        }
    }
}

extension MyProjectTableViewCell {
    private func calculateDays(date: String) -> Int {
        let dateFormatter = DateFormatter()
        var daysCount:Int = 0
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let startDate = dateFormatter.date(from: date) else { return 0 }
        daysCount = days(from: startDate)
        return daysCount
    }
    
    private func days(from date: Date) -> Int {
        let calendar = Calendar.current
        let currentDate = Date()
        return (calendar.dateComponents([.day], from: date, to: currentDate).day ?? 0) + 1
    }
}

extension MyProjectTableViewCell {
    func setDataBind(_ data: MyProjectDataModel) {
        projectNameLabel.text  = data.projectName
        let duration:Int = calculateDays(date: data.startDate)
        if (duration < 0) {
            durationLabel.text = "D - \(duration * (-1))"
        }
        else {
            durationLabel.text = "D + \(duration)"
        }
    }
}
