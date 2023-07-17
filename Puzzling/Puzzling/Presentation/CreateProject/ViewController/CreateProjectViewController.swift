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
    
    private var project: Project
    private var projectName: String = ""
    private var projectDescription: String = ""
    private var projectStartDate: String = ""
    private var projectRole: String = ""
    private var projectNickname: String = ""
    private var projectCycle: [String] = []
    private var viewHeight: String = ""
    private let projectProvider = MoyaProvider<ProjectService>(plugins:[NetworkLoggerPlugin()])
    
    // MARK: - Initializer
    
    init() {
        project = Project(projectName: "", projectIntro: "", projectStartDate: "", memberProjectRole: "", memberProjectNickname: "", reviewCycle: [])
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        setupKeyboardEvent()
    }
    
    deinit {
        print("CreateProjectViewController")
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("textFieldNotification"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("startDateNotification"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("cycleNotification"), object: nil)
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
    
    private func setNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(getTextFieldInfo(_:)), name: Notification.Name("textFieldNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getStartDateInfo(_:)), name: Notification.Name("startDateNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getCycleInfo(_:)), name: Notification.Name("cycleNotification"), object: nil)
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
        print("-------------------------------------------")
        print(projectName)
        print(projectDescription)
        print(replaceDate(date: projectStartDate))
        print(projectRole)
        print(projectNickname)
        print(projectCycle)
        let alert = CustomAlertView(frame: CGRect(x: 0, y: 0, width: 290, height: 373), alertType: .createProject)
        alert.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(alert)
        alert.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        alert.isUserInteractionEnabled = true
    }
    
    private func getSelectedProjectCycle(list: [Int]) -> [String] {
        let dayOfWeekMap: [Int: String] = [
            0: "월",
            1: "화",
            2: "수",
            3: "목",
            4: "금",
            5: "토",
            6: "일"
        ]
        
        let dayOfWeekList = list.sorted().compactMap { dayOfWeekMap[$0] }
        return dayOfWeekList
    }
    
    private func buttonStateSetting() {
        if (!projectName.isEmpty && !projectDescription.isEmpty && !projectStartDate.isEmpty &&
            !projectRole.isEmpty && !projectNickname.isEmpty && !projectCycle.isEmpty) {
            registerProjectButton.setState(.allow)
        } else {
            registerProjectButton.setState(.notAllow)
        }
    }
    
    private func replaceDate(date: String) -> String {
        let originalString = date
        let modifiedString = originalString.replacingOccurrences(of: "/", with: "-")
        return modifiedString
    }
    
    private func setupKeyboardEvent() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)

    }
    
    private func invitationCodeNotification(code: String) {
        let userInfo = code
        NotificationCenter.default.post(
            name: Notification.Name("invitationCodeNotification"),
            object: nil,
            userInfo: ["userInfo": userInfo]
        )
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func registerProjectButtonDidTap() {
        projectRegister()
        postProjectInfo()
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
                projectNickname = updateTextInfo.text
            case .invitationCode:
                return
            }
            buttonStateSetting()
        }
    }
    
    @objc
    private func getStartDateInfo(_ notification: Notification) {
        if let dateInfo = notification.userInfo?["userInfo"] as? String {
            projectStartDate = dateInfo
            buttonStateSetting()
        }
    }
    
    @objc
    private func getCycleInfo(_ notification: Notification) {
        if let cycleInfo = notification.userInfo?["userInfo"] as? [Int] {
            projectCycle = getSelectedProjectCycle(list: cycleInfo)
            buttonStateSetting()
        }
    }
    
    @objc
    private func keyboardWillShow(_ sender: Notification) {
        guard let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentResponder as? UITextField else { return }
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        if textFieldBottomY > keyboardTopY {
            let keyboardOverlap = textFieldBottomY - keyboardTopY
            view.frame.origin.y = -keyboardOverlap - 40
        }
    }
    
    @objc
    private func keyboardWillHide(_ sender: Notification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
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

extension CreateProjectViewController {
    
    // MARK: - Network
    
    private func postProjectInfo() {
        project.projectName = projectName
        project.projectIntro = projectDescription
        project.projectStartDate = replaceDate(date: projectStartDate)
        project.memberProjectRole = projectRole
        project.memberProjectNickname = projectNickname
        project.reviewCycle = projectCycle
        
        projectProvider.request(.postProject(param: project.makePostProjectRequest(), memberID: "1")) { result in
            switch result {
            case .success(let result):
                let status = result.statusCode
                if status >= 200 && status < 300 {
                    do {
                        print("♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️")
                        self.invitationCodeNotification(code: "2150811453")
                        guard let data = try result.map(GeneralResponse<PostProjectRequest>.self).data else {
                            return
                        }
//                        self.invitationCode = data
                    } catch(let error) {
                        print(error.localizedDescription)
                    }
                }
                else if status >= 400 {
                    print("⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
