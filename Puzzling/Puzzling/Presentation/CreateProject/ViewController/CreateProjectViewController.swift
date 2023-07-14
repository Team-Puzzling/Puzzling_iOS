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
    private var projectName: String = ""
    private var projectDescription: String = ""
    private var projectStartDate: String = ""
    private var projectRole: String = ""
    private var projectNickname: String = ""
    private var projectCycle: [String] = []
    
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
        setNotificationCenter()
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
            $0.setState(.allow)
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
    
    private func setNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(getTextFieldInfo(_:)), name: Notification.Name("textFieldNotification"), object: nil)
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
    
    private func projectRegister() {
        print("registerProjectButtonTap!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        print(projectName)
        print(projectDescription)
        print(projectStartDate)
        print(projectRole)
        print(projectNickname)
        print(projectCycle)
    }
    
    @objc
    private func registerProjectButtonDidTap() {
        projectRegister()
    }
    
    @objc
    private func getTextFieldInfo(_ notification: Notification) {
        if let textInfo = notification.userInfo as? [String: TextFieldInfo], let updateTextInfo = textInfo["userInfo"] {
            switch updateTextInfo.type {
            case .name:
                projectName = updateTextInfo.text
            case .description:
                projectDescription = updateTextInfo.text
            case .role:
                projectRole = updateTextInfo.text
            case .nickname:
                projectRole = updateTextInfo.text
            }
        }
    }
}

// MARK: - UISheetPresentationControllerDelegate

extension CreateProjectViewController: UISheetPresentationControllerDelegate { }

extension CreateProjectViewController: ProjectStartProtocol {
    func presentToStartTimeVC() {
        presentToHalfModalViewController()
    }
}
