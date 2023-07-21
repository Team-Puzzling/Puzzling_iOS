//
//  ProjectNameCollectionReusableView.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/14.
//

import UIKit

import SnapKit
import Then

protocol buttonTappedProtocol: AnyObject {
    func passButtonEvent(projectName: String)
}

final class ProjectNameCollecionReusableView: UICollectionReusableView {
    
    // MARK: - UI Components
    
    private let button = UIButton()
    private let projectNameLabel = UILabel()
    private let chevronDownImageView = UIImageView()
    
    // MARK: - Properties
    
    weak var delegate: buttonTappedProtocol?
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProjectNameCollecionReusableView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        button.do {
            $0.makeRounded(radius: 16)
            $0.backgroundColor = .background050
        }
        
        projectNameLabel.do {
            $0.font = .fontGuide(.body1_bold_kor)
            $0.sizeToFit()
        }
        
        chevronDownImageView.do {
            $0.image = Image.chevronDown
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        self.addSubview(button)
        button.addSubviews(projectNameLabel, chevronDownImageView)
        
        button.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(4)
            $0.height.equalTo(36)
        }
        
        projectNameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(18)
            $0.trailing.equalTo(chevronDownImageView.snp.leading).offset(-2)
            $0.centerY.equalToSuperview()
        }
        
        chevronDownImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(6)
            $0.size.equalTo(36)
        }
    }
    
    // MARK: - Methods
    
    private func setAddTarget() {
        button.addTarget(self, action: #selector(projectButtonTapped), for: .touchUpInside)
    }
}

extension ProjectNameCollecionReusableView {
    
    // MARK: - @objc Methods
    
    @objc
    func projectButtonTapped() {
        guard let text = projectNameLabel.text else { return }
        self.delegate?.passButtonEvent(projectName: text)
    }
}

extension ProjectNameCollecionReusableView {
    func setDataBind(projectName: String) {
        projectNameLabel.text = projectName
    }
}
