//
//  CreateRetrospectViewController.swift
//  Puzzling
//
//  Created by 천성우 on 2023/07/10.
//

import UIKit

import Then
import SnapKit

final class CreateRetrospectViewController: UIViewController {
    
    // templates didset
    
    private let templatesButton = UIButton().then {
        $0.backgroundColor = .background050
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.background050.cgColor
        $0.layer.cornerRadius = 16
        $0.addTarget(self,
                     action: #selector(presentButtonTapped),
                     for: .touchUpInside)
    }
    
    private var tilView: TILView! = TILView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setUI()
        setLayout()
    }
    
    private func setDelegate() {
        
    }
    
    private func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(templatesButton)
        view.addSubview(tilView)
        
        templatesButton.snp.makeConstraints{
            $0.top.equalToSuperview().inset(112)
            $0.leading.equalToSuperview().inset(18)
            $0.width.equalTo(88)
            $0.height.equalTo(36)
        }
        
        tilView.snp.makeConstraints {
            $0.top.equalTo(templatesButton.snp.bottom).inset(-24)
            $0.trailing.leading.equalToSuperview().inset(16)
        }
    }
    
    private func setLayout() {
        
    }
    
    func presnetToBottomSheetViewController() {
        print(self.view.subviews[1])
        let VC = BottomSheetViewController()
        self.present(VC, animated: true)
    }
    
    @objc
    func presentButtonTapped() {
        presnetToBottomSheetViewController()
//        tilView.removeFromSuperview()
//        tilView = nil
//        print(tilView)
        print(self.view.subviews)
    }
}

