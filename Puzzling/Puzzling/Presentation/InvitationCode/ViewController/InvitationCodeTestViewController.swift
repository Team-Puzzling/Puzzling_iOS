//
//  InvitationCodeTestViewController.swift
//  Puzzling
//
//  Created by KJ on 2023/07/17.
//

import UIKit

import Moya
import SnapKit
import Then

final class InvitationCodeTestViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let testButton = UIButton()
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
}

extension InvitationCodeTestViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        view.backgroundColor = .background050
        
        testButton.do {
            $0.setTitle("초대코드 뷰 테스트", for: .normal)
            $0.backgroundColor = .blue200
            $0.addTarget(self, action: #selector(testButtonDidTap), for: .touchUpInside)
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        view.addSubview(testButton)
        
        testButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    // MARK: - @objc Methods
    
    @objc
    private func testButtonDidTap() {
        let vc = InvitationCodeViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
