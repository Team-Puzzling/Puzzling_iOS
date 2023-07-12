//
//  CreateProjectViewController.swift
//  Puzzling
//
//  Created by KJ on 2023/07/11.
//

import UIKit

import Moya
import SnapKit
import Then

final class CreateProjectViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let navigationView = UIView()
    private let navigationTitleLabel = UILabel()
    private let closeButton = UIButton()
    private let nameView = InputContentView(type: .name)
    private let descriptionView = InputContentView(type: .description)
    private let startDayView = StartDayView()
    private let roleView = InputContentView(type: .role)
    private let nicknameView = InputContentView(type: .nickname)
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
}

extension CreateProjectViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        view.backgroundColor = .white000
        
        navigationTitleLabel.do {
            $0.text = "프로젝트 등록하기"
            $0.font = .fontGuide(.heading4_kor)
        }
        
        closeButton.do {
            $0.setImage(Image.xMark, for: .normal)
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        navigationView.addSubviews(navigationTitleLabel, closeButton)
        view.addSubviews(navigationView, nameView, startDayView,
                         descriptionView, roleView, nicknameView)
        
        navigationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48)
        }
        
        navigationTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(8)
            $0.width.height.equalTo(48)
        }
        
        nameView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(32)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(106)
        }
        
        descriptionView.snp.makeConstraints {
            $0.top.equalTo(nameView.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(nameView)
            $0.height.equalTo(nameView)
        }
        
        startDayView.snp.makeConstraints {
            $0.top.equalTo(descriptionView.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(nameView)
            $0.height.equalTo(50)
        }
        
        roleView.snp.makeConstraints {
            $0.top.equalTo(startDayView.snp.bottom).offset(40)
            $0.leading.trailing.equalTo(nameView)
            $0.height.equalTo(nameView)
        }
        
        nicknameView.snp.makeConstraints {
            $0.top.equalTo(roleView.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(nameView)
            $0.height.equalTo(nameView)
        }
        
    }
    
    // MARK: - Methods
    
    // MARK: - @objc Methods
}
