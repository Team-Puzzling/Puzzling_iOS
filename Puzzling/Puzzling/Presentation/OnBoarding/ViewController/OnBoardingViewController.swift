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
    func tapAction(value: String)
}

extension OnBoardingViewContoller: TappedDelegate {
    func tapAction(value: String) {
        print("receive data \(value)")
        kakaoLogin()
    }
}

final class OnBoardingViewContoller: UIViewController {
    
    private let authProvider = MoyaProvider<AuthService>(plugins:[NetworkLoggerPlugin()])
    private var authModel: AuthModel = AuthModel(socialPlatform: "")
    private var user: User = User(name: "", memberID: 0, projectID: nil, accessToken: "", refreshToken: "", isNewUser: false)
    private var userModel: UserModel = UserModel(name: "", memberID: 0, projectID: nil, accessToken: "", refreshToken: "", isNewUser: false)
    private var auth: Auth = Auth(socialPlatform: "")
    private var socialPlatform: String = ""
    private var token: String = ""
    // MARK: - UI Components
    
    private let onBoardingView = OnBoardingView()
    private let enterProjectView = EnterProjectView()
    
    // MARK: - Properties
    
    
    // MARK: - Initializer
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    // MARK: - Methods
    
}

private extension OnBoardingViewContoller {
    
    func kakaoLogin() {
        auth.socialPlatform = "KAKAO"
        print(socialPlatform,"????")
        if (UserApi.isKakaoTalkLoginAvailable()) {
            //카톡 설치되어있으면 -> 카톡으로 로그인
            print("카카오톡 있음 🙏🙏🙏🙏🙏🙏🙏")
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print("😭😭😭😭",error)
                } else {
                    guard let accessToken = oauthToken?.accessToken else { return }
                    print("loginWithKakaoTalk() success.")
                    print("🐶🐶🐶🐶🐶🐶🐶🐶🐶🐶🐶🐶🐶", accessToken, "🐶🐶🐶🐶🐶🐶🐶🐶🐶🐶🐶🐶🐶")
                    self.token = accessToken
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

                    _ = oauthToken
                    // 관련 메소드 추가
                    self.postAuth()
                        UserDefaults.standard.set(true, forKey: "Login")
                }
            }
        }
    }
    
    func saveToken() {
        UserDefaults.standard.set(true, forKey: "Login")
    }
    
    func gotoMainEnterProjectView() {
        print(#function)
        let vc = EnterProjectViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension OnBoardingViewContoller {

    // MARK: - Network
    
    private func postAuth() {
        print(auth.socialPlatform)
        authProvider.request(.postAuth(param: auth.makePostAuthRequest(), token: token)) { result in
            switch result {
            case .success(let result):
                let status = result.statusCode
                if status >= 200 && status < 300 {
                    do {
                        print("?????????\(result.data)")
                        guard let data = try result.map(GeneralResponse<UserResponse>.self).data else { return }
                        self.userModel = data.convertoToUserModel()
                        print("🥰🥰🥰🥰🥰🥰🥰🥰🥰🥰🥰🥰🥰🥰🥰🥰🥰🥰🥰\(self.userModel)🥰🥰🥰🥰🥰🥰🥰🥰🥰🥰🥰🥰🥰🥰🥰🥰🥰🥰")
                        
                        self.gotoMainEnterProjectView()
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
        authProvider.request(.authToken) { result in
            switch result {
            case .success(let result):
                let status = result.statusCode
                if status >= 200 && status < 300 {
                    do {
                        guard let data = try result.map(GeneralResponse<UserResponse>.self).data else { return }
                        self.userModel = data.convertoToUserModel()
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
            print("wwwwwww")
        }
    }
}
