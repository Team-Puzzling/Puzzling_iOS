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
    private let createProjectView = CreateProjectView()
    private let registerProjectButton = CheckButton()
    
    // MARK: - Properties
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: 311)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setAddTarget()
        setDelegate()
    }
    
    deinit {
        print("CreateProjectViewController")
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
        
        registerProjectButton.do {
            $0.setTitle("프로젝트 등록하기", for: .normal)
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        navigationView.addSubviews(navigationTitleLabel, closeButton)
        view.addSubviews(navigationView, createProjectView, registerProjectButton)
        
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
        
        registerProjectButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(50)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(55)
        }
        
        createProjectView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(registerProjectButton.snp.top).offset(-25)
        }
    }
    
    // MARK: - Methods
    
    private func setAddTarget() {
        registerProjectButton.addTarget(self, action: #selector(registerProjectButtonDidTap), for: .touchUpInside)
    }
    
    private func setDelegate() {
        createProjectView.startDayView.projectStartDelegate = self
    }
    
    func presentToHalfModalViewController() {
        let projectStartTimeVC = ProjectStartTimeViewController()
        projectStartTimeVC.modalPresentationStyle = .pageSheet
        let screenHeight = UIScreen.main.bounds.height
        let customDetentIdentifier = UISheetPresentationController.Detent.Identifier("customDetent")
        let customDetent = UISheetPresentationController.Detent.custom(identifier: customDetentIdentifier) { (_) in
            if screenHeight > 670 {
                return 311
            } else {
                return 330
            }
        }
        
        if let sheet = projectStartTimeVC.sheetPresentationController {
            sheet.detents = [customDetent]
            sheet.preferredCornerRadius = 16
            sheet.delegate = self
            sheet.prefersGrabberVisible = true
        }
        present(projectStartTimeVC, animated: true, completion: nil)
    }
    
    @objc
    private func registerProjectButtonDidTap() {
        print("registerProjectButtonTap!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    }
}

// MARK: - UISheetPresentationControllerDelegate

extension CreateProjectViewController: UISheetPresentationControllerDelegate { }

extension CreateProjectViewController: ProjectStartProtocol {
    func presentToStartTimeVC() {
        presentToHalfModalViewController()
    }
}
