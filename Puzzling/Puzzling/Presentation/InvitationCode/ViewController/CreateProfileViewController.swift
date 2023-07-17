//
//  CreateProfileViewController.swift
//  Puzzling
//
//  Created by KJ on 2023/07/17.
//

import UIKit

import Moya
import SnapKit
import Then

final class CreateProfileViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let navigationView = UIView()
    private let navigationTitleLabel = UILabel()
    private let closeButton = UIButton()
    private let projectNameLabel = UILabel()
    private let lineView = UIView()
    private let nicknameView = InputContentView(type: .nickname)
    private let myRoleView = InputContentView(type: .role)
    private let participateProjectButton = CheckButton()
    
    // MARK: - Properties
    
    private var profile: ProfileModel
    var projectName: String?
    var projectID: Int?
    private var nickname: String = ""
    private var myRole: String = ""
    private let profileProvider = MoyaProvider<ProjectService>(plugins:[NetworkLoggerPlugin()])
    
    // MARK: - Initializer
    
    init() {
        profile = ProfileModel(projectId: 0, memberProjectNickname: "", memberProjectRole: "")
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        let vc = InvitationCodeViewController()
        vc.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setAddTarget()
        setTapScreen()
        setNotification()
        setProjectNameLabel()
    }
}

extension CreateProfileViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        view.backgroundColor = .white000
        
        navigationView.do {
            $0.backgroundColor = .clear
        }
        
        navigationTitleLabel.do {
            $0.text = "프로필 작성하기"
            $0.font = .fontGuide(.heading4_kor)
            $0.textColor = .black000
        }
        
        closeButton.do {
            $0.setImage(Image.xMark, for: .normal)
        }
        
        projectNameLabel.do {
            $0.text = "프로젝트: "
            $0.font = .fontGuide(.body1_bold_kor)
            $0.textColor = .black000
        }
        
        lineView.do {
            $0.backgroundColor = .gray200
        }
        
        participateProjectButton.do {
            $0.setTitle("프로젝트 참여하기", for: .normal)
            $0.setState(.notAllow)
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        navigationView.addSubviews(navigationTitleLabel, closeButton)
        view.addSubviews(navigationView, projectNameLabel, lineView,
                         nicknameView, myRoleView, participateProjectButton)
        
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
            $0.trailing.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
        }
        
        projectNameLabel.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(40)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(projectNameLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(1)
        }
        
        nicknameView.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(32)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(106)
        }
        
        myRoleView.snp.makeConstraints {
            $0.top.equalTo(nicknameView.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(nicknameView)
            $0.height.equalTo(106)
        }
        
        participateProjectButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(50)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(55)
        }
    }
    
    // MARK: - Methods
    
    private func setAddTarget() {
        closeButton.addTarget(self, action: #selector(closeButotnDidTap), for: .touchUpInside)
        participateProjectButton.addTarget(self, action: #selector(participateProjectButtonDidTap), for: .touchUpInside)
    }

    private func setTapScreen() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapScreen))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(getTextFieldInfo(_:)), name: Notification.Name("textFieldNotification"), object: nil)
    }
    
    private func buttonStateSetting() {
        if (!nickname.isEmpty && !myRole.isEmpty) {
            participateProjectButton.setState(.allow)
        } else {
            participateProjectButton.setState(.notAllow)
        }
    }
    
    private func dismissToMain() {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    private func participateProject() {
//        print("participateProject")
//        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    private func setProjectNameLabel() {
        if let projectName = self.projectName {
            projectNameLabel.text = "프로젝트: \(projectName)"
        }
    }
    
    private func textFieldWarningNotification(type: WarningMessage) {
        let userInfo = type
        NotificationCenter.default.post(
            name: Notification.Name("textFieldWarningNotification"),
            object: nil,
            userInfo: ["userInfo": userInfo]
        )
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func closeButotnDidTap() {
        dismissToMain()
    }
    
    @objc
    private func participateProjectButtonDidTap() {
        postProfileInfo()
        participateProject()
    }
    
    @objc
    private func didTapScreen(_ gesture: UITapGestureRecognizer) {
        gesture.location(in: self.view)
        self.view.endEditing(true)
    }
    
    @objc
    private func getTextFieldInfo(_ notification: Notification) {
        if let textInfo = notification.userInfo as? [String: TextFieldInfo], let updateTextInfo = textInfo["userInfo"] {
            if updateTextInfo.type == .nickname {
                nickname = updateTextInfo.text
            } else if updateTextInfo.type == .role {
                myRole = updateTextInfo.text
            }
            buttonStateSetting()
        }
    }
}

extension CreateProfileViewController {
    
    // MARK: - Network
    
    private func postProfileInfo() {
        if let id = projectID {
            profile.projectId = id
        }
        profile.memberProjectNickname = nickname
        profile.memberProjectRole = myRole
        
        profileProvider.request(.joinProject(param: profile.makePostProfileRequest(), memberID:"1")) { result in
            switch result {
            case .success(let result):
                let status = result.statusCode
                if status >= 200 && status < 300 {
                    do {
                        guard let data = try result.map(GeneralResponse<PostProfileRequest>.self).data else { return }
                        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                    } catch(let error) {
                        print(error.localizedDescription)
                        self.participateProjectButton.setState(.notAllow)
                    }
                }
                else if status == 400 {
                    print("⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️")
                    do {
                        let generalResponse = try result.map(GeneralResponse<PostProfileRequest>.self)
                        guard let message = generalResponse.message else { return }
                        if message == "이미 프로젝트에 있는 닉네임입니다." {
                            self.textFieldWarningNotification(type: .duplicateNickname)
                        } else if message == "이미 프로젝트에 참여한 팀원입니다." {
                            print("🌧️🌧️🌧️🌧️🌧️🌧️🌧️🌧️🌧️🌧️🌧️🌧️🌧️🌧️🌧️🌧️🌧️🌧️🌧️🌧️")
                        } else { print("에러 잼") }
                    } catch(let error) {
                        print(error.localizedDescription)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
