//
//  ProjectStartTimeViewController.swift
//  Puzzling
//
//  Created by KJ on 2023/07/14.
//

import UIKit

import Moya
import SnapKit
import Then

final class ProjectStartTimeViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let datePicker = UIDatePicker()
    private let saveButton = CheckButton()
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setAddTarget()
    }
    
    deinit {
        print("ProjectStartTimeViewController")
    }
}

extension ProjectStartTimeViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        view.backgroundColor = .white000
        
        datePicker.do {
            $0.datePickerMode = .date
            $0.preferredDatePickerStyle = .wheels
            $0.backgroundColor = UIColor.white
            $0.locale = Locale(identifier: "ko-KR")
            $0.minuteInterval = 30
        }
        
        saveButton.do {
            $0.setTitle("확인", for: .normal)
            $0.setState(.allow)
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        view.addSubviews(datePicker, saveButton)
        
        saveButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(50)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(55)
        }
        
        datePicker.snp.makeConstraints {
            $0.bottom.equalTo(saveButton.snp.top).offset(-25)
            $0.leading.trailing.equalTo(saveButton)
            $0.height.equalTo(181)
        }
    }
    
    // MARK: - Methods
    
    private func setAddTarget() {
        saveButton.addTarget(self, action: #selector(saveButtonDidTap), for: .touchUpInside)
    }
    
    private func dismissToCreateProjectVC() {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy/MM/dd"
        let strDate = timeFormatter.string(from: datePicker.date)
        let userInfo = ["selectedDate": strDate]
        NotificationCenter.default.post(name: Notification.Name("SelectedDateNotification"), object: nil, userInfo: userInfo)
        self.dismiss(animated: true)
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func saveButtonDidTap() {
        dismissToCreateProjectVC()
    }
}
