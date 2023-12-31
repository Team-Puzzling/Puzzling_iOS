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
    
    // MARK: - @objc Methods
    
    @objc
    private func setButton() {
        rootView.newProjectButtonHandler  = { [weak self] in
            self?.newProjectButtonDidTap()
        }
        rootView.joinButtonHandler = { [weak self] in
            self?.joinButtonDidTap()
        }
    }
    
    @objc
    private func newProjectButtonDidTap() {
        let createProjectVC = CreateProjectViewController()
        createProjectVC.modalPresentationStyle = .fullScreen
        self.present(createProjectVC, animated: true)
    }
    
    @objc
    private func joinButtonDidTap() {
        let invitationCodeVC = InvitationCodeViewController()
        invitationCodeVC.modalPresentationStyle = .fullScreen
        self.present(invitationCodeVC, animated: true)
    }
}
