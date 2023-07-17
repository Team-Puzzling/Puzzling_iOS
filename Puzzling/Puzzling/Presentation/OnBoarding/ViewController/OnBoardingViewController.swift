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

final class OnBoardingViewContoller: UIViewController {
    
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
    }
}

extension OnBoardingViewContoller {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        view.backgroundColor = .white000
        
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        view.addSubviews(OnBoardingView)
        
        OnBoardingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    // MARK: - Methods
    
    
    // MARK: - @objc Methods
    
}
