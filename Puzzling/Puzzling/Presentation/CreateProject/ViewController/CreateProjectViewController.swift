//
//  CreateProjectViewController.swift
//  Puzzling
//
//  Created by KJ on 2023/07/11.
//

import UIKit

import Moya
import SnapKit
import Then

final class CreateProjectViewController: UIViewController {
    
    // MARK: - UI Components
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setNavigationBar()
    }
}

extension CreateProjectViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        view.backgroundColor = .white000
        
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
    }
    
    // MARK: - Methods
    
    private func setNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black000,
            .font: UIFont.fontGuide(.heading4_kor)
        ]
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: Image.icnClose)
//            style: .plain,
//            target: self,
//            action: #selector(backButtonTapped))
        navigationItem.title = "프로젝트 등록하기"
        navigationController?.navigationBar.tintColor = .gray500
    }
    
    // MARK: - @objc Methods
}
