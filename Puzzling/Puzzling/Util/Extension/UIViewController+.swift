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
    
    func showToast(withImage image: UIImage?, message: String) {
        let toastView = UIView().then {
            $0.backgroundColor = .blue400
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
            self.view.addSubview($0)
            
            $0.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.bottom.equalToSuperview().offset(-40)
                make.width.equalToSuperview().multipliedBy(0.9) // Set width to 90% of the screen width
                make.height.equalTo(60) // Set height to 60
            }
        }
        
        if let image = image {
            let imageView = UIImageView().then {
                $0.contentMode = .scaleAspectFit
                $0.image = image
                toastView.addSubview($0)
                
                $0.snp.makeConstraints { make in
                    make.centerY.equalToSuperview()
                    make.leading.equalToSuperview().offset(10) // Set left padding to 10
                    make.width.height.equalTo(30)
                }
            }
        }
        
        let textLabel = UILabel().then {
            $0.textColor = UIColor.white
            $0.textAlignment = .left
            $0.font = UIFont.systemFont(ofSize: 15)
            $0.text = message
            toastView.addSubview($0)
            
            $0.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                if let image = image {
                    make.leading.equalTo(toastView.subviews.first!.snp.trailing).offset(10)
                } else {
                    make.leading.equalToSuperview().offset(10)
                }
                make.trailing.equalToSuperview().offset(-10)
            }
        }
        
        UIView.animate(withDuration: 0.3, delay: 2.0, options: .curveEaseOut, animations: {
            toastView.alpha = 0.0
        }, completion: { _ in
            toastView.removeFromSuperview()
        })
    }
}
