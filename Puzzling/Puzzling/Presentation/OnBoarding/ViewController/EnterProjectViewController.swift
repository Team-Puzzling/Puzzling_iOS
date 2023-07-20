//
//  EnterProjectViewController.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/19.
//

import UIKit

import Moya
import SnapKit
import Then

final class EnterProjectViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let rootView = EnterProjectView()
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButton()
    }
    
    override func loadView() {
        self.view = rootView
    }
}

extension EnterProjectViewController {
    
    // MARK: - Methods
    
    @objc
    private func setButton() {
        rootView.newProjectButtonhandler  = { [weak self] in
            self?.newProjectButtonDidTap()
        }
    }
    
    @objc
    private func newProjectButtonDidTap() {
        let createProjectVC = CreateProjectViewController()
        createProjectVC.modalPresentationStyle = .fullScreen
        self.present(createProjectVC, animated: true)
    }
}
