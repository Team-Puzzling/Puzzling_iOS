//
//  testViewController.swift
//  Puzzling
//
//  Created by 천성우 on 2023/07/13.
//

import UIKit

import Then
import SnapKit

class testViewController: UIViewController {
    
    private let pushButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUI()
        setLayout()
        setDelegate()
    }
    
    private func setUI() {
        view.backgroundColor = .systemIndigo
        
        view.addSubview(pushButton)
        
        pushButton.do {
            $0.setTitle("규보심의 뷰에서 나오는 버튼~", for: .normal)
            $0.addTarget(self,
                        action: #selector(pushButtonTapped),
                        for: .touchUpInside)
        }
        pushButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func setLayout() {
        
    }
    
    private func setDelegate() {
        
    }
    
    func pushToCreateRetrospectViewController() {
        let VC = CreateRetrospectViewController()
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc
    func pushButtonTapped() {
        pushToCreateRetrospectViewController()
    }
}
