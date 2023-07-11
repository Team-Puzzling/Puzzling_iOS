//
//  HomeTitleBarView.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/10.
//

import UIKit

import SnapKit
import Then

protocol HomeBottomSheetDelegate: AnyObject {
    func openBottomSheet()
    func popAlarmAction()
}

final class HomeTitleBarView: UIView {
    
    private let titleLabel = UILabel()
    private let chevronImageView = UIImageView()
    
    private let titleStackView = UIStackView()
    
    private lazy var alarmButton = UIButton(frame: .zero, primaryAction: setAlarmAction())
    
    weak var delegate: HomeBottomSheetDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        setActions()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleStackView.snp.makeConstraints {
            $0.width.lessThanOrEqualTo(self.snp.width).multipliedBy(0.7)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeTitleBarView {
    
    private func setUI() {
        titleLabel.do {
            $0.font = .fontGuide(.heading1_kor)
            $0.textColor = .black000

            $0.text = "프로젝트 이름"
        }
        
        chevronImageView.do {
            $0.image = Image.chevronDown
            $0.contentMode = .scaleAspectFit
        }
        
        titleStackView.do {
            $0.axis = .horizontal
            $0.spacing = 0
            $0.alignment = .center
            $0.isUserInteractionEnabled = true
        }
        
        alarmButton.do {
            $0.setImage(Image.notificationBell, for: .normal)
        }
    }
    
    private func setLayout() {
        self.addSubviews(titleStackView, alarmButton)
        titleStackView.addArrangedSubviews(titleLabel, chevronImageView)
        
        titleStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        chevronImageView.snp.makeConstraints {
            $0.size.equalTo(36)
        }
        
        alarmButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(48)
        }
    }
    
    private func setActions() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openBottomSheetTapped))
        titleStackView.addGestureRecognizer(tapGestureRecognizer)
    }
}

extension HomeTitleBarView {
    private func setAlarmAction() -> UIAction? {
        let action = UIAction(handler: { [weak self] _ in
            print("aaaaaaaa")
            self?.delegate?.popAlarmAction()
        })
        return action
    }
    
    @objc
    private func openBottomSheetTapped() {
        self.delegate?.openBottomSheet()
    }
}

extension HomeTitleBarView {
    func setTitleOfProject(title: String?) {
        self.titleLabel.text = title
    }
}
