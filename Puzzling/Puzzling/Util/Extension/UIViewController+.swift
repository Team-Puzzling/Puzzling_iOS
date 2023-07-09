//
//  UIViewController+.swift
//  Puzzling-iOS
//
//  Created by KJ on 2023/07/04.
//

import UIKit

extension UIViewController {
    
    func showAlert(alertText : String, alertMessage : String) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    public static func modifyRootViewController (_ viewController: UIViewController) {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let navigationViewController = UINavigationController(rootViewController: viewController)
        sceneDelegate?.window?.rootViewController = navigationViewController
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}
