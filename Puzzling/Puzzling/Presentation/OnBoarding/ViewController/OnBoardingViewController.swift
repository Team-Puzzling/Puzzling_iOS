//
//  OnBoardingViewController.swift
//  Puzzling
//
//  Created by 천성우 on 2023/07/17.
//

import UIKit

import Moya
import SnapKit
import Then

import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

import Security

protocol TappedDelegate: AnyObject {
    func tapAction()
}

extension OnBoardingViewContoller: TappedDelegate {
    func tapAction() {
        kakaoLogin()
    }
}

final class OnBoardingViewContoller: UIViewController {
    
    // MARK: - UI Components
    
    private let onBoardingView = OnBoardingView()
    private let enterProjectView = EnterProjectView()
    
    // MARK: - Properties
    
    private let authProvider = MoyaProvider<AuthService>(plugins:[NetworkLoggerPlugin()])
    private var authModel: AuthModel = AuthModel(socialPlatform: "")
    private var userModel: UserModel = UserModel(name: "", memberId: 0, projectId: nil, accessToken: "", refreshToken: "", isNewUser: false)
    private var tokenModel: TokenModel = TokenModel(accessToken: "")
    private var socialPlatform: String = ""
    private var token: String = ""
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isExistUserInform()
        setUI()
        setLayout()
        onBoardingView.delegate = self
    }
}

extension OnBoardingViewContoller {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        view.backgroundColor = .white000
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        view.addSubviews(onBoardingView)
        
        onBoardingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

private extension OnBoardingViewContoller {
    
    // MARK: - Methods
    
    func isExistUserInform() {
        if let login = UserDefaults.standard.object(forKey: "Login") {
            if(login as! Int == 0) {
                return
            } else {
                if let project = UserDefaults.standard.object(forKey: "projectId") {
                    self.gotoMainPage()
                } else {
                    self.gotoMainEnterProjectView()
                }
            }
        }
        else { return }
    }
    
    func kakaoLogin() {
        authModel.socialPlatform = "KAKAO"
        if (UserApi.isKakaoTalkLoginAvailable()) {
            // 카톡 설치되어있으면 -> 카톡으로 로그인
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    guard let accessToken = oauthToken?.accessToken else { return }
                    print("loginWithKakaoTalk() success.")
                    APIConstants.kakaoAccessToken = accessToken
                    self.postAuth()
                }
            }
        } else {
            // 카톡 없으면 -> 계정으로 로그인
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("loginWithKakaoAccount() success.")
                    guard let accessToken = oauthToken?.accessToken else { return }
                    APIConstants.kakaoAccessToken = accessToken
                    _ = oauthToken
                    // 관련 메소드 추가
                    self.postAuth()
                }
            }
        }
    }
    
    func gotoMainEnterProjectView() {
        let vc = EnterProjectViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoMainPage() {
        let vc = TabBarController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension OnBoardingViewContoller {
    
    // MARK: - Network
    
    private func postAuth() {
        print(authModel.socialPlatform)
        authProvider.request(.postAuth(param: authModel.makePostAuthRequest())) { result in
            switch result {
            case .success(let result):
                let status = result.statusCode
                if status >= 200 && status < 300 {
                    do {
                        guard let data = try result.map(GeneralResponse<UserResponse>.self).data else { return }
                        self.userModel = data.convertToUserModel()
                        UserDefaults.standard.set(self.userModel.name, forKey: "name")
                        UserDefaults.standard.set(self.userModel.projectId, forKey: "projectId")
                        UserDefaults.standard.set(self.userModel.memberId, forKey: "memberId")
                        KeyChain.create(key: "accessToken", token: self.userModel.accessToken)
                        KeyChain.create(key: "refreshToken", token: self.userModel.refreshToken)
//                        APIConstants.accessToken = self.userModel.accessToken
                        
                        if(self.userModel.isNewUser == true) {
                            self.gotoMainEnterProjectView()
                        }
                        else if(self.userModel.projectId == nil) {
                            self.gotoMainEnterProjectView()
                        }
                        else {
                            self.gotoMainPage()
                        }
                        UserDefaults.standard.set(true, forKey: "Login")
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
    
    func getNewToken() {
        guard let access = KeyChain.read(key: "accessToken") else { return }
        guard let refresh = KeyChain.read(key: "refreshToken") else { return }
        authProvider.request(.authToken(Authorization: access, Refresh: refresh)) { result in
            switch result {
            case .success(let result):
                let status = result.statusCode
                if status >= 200 && status < 300 {
                    do {
                        guard let data = try result.map(GeneralResponse<TokenResponse>.self).data else { return }
                        self.tokenModel = data.convertToTokenModel()
                        KeyChain.create(key: "accessToken", token: self.tokenModel.accessToken)
                        APIConstants.accessToken = self.tokenModel.accessToken
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
