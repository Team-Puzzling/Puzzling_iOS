//
//  SceneDelegate.swift
//  Puzzling-iOS
//
//  Created by KJ on 2023/07/04.
//

import UIKit

import KakaoSDKAuth
import Moya

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
//    var vc: UIViewController = UIViewController()

    private let authProvider = MoyaProvider<AuthService>(plugins:[NetworkLoggerPlugin()])
    private var tokenModel: TokenModel = TokenModel(accessToken: "")
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let vc = setVC()
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.isHidden = true
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

extension SceneDelegate {
    
    func setVC() -> UIViewController {
        if let login = UserDefaults.standard.object(forKey: "Login") {
            if(login as! Int == 0) {
                return OnBoardingViewContoller()
            } else {
                if let project = UserDefaults.standard.object(forKey: "projectId") {
                    return TabBarController()
                } else {
                    return EnterProjectViewController()
                }
            }
        }
        else { return OnBoardingViewContoller() }
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
