//
//  MyProjectViewController.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class MyProjectViewController: UIViewController {
    
    private let nickname: String = "공듀"
    
    private let myProjectTableView = UITableView()
    private let nicknameLabel = UILabel()
    
    private let MyProjectData = MyProjectDataModel.dummy()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setUI()
        setLayout()
        setTarget()
        setDelegate()
        setRegister()
    }
}

extension MyProjectViewController {
    
    private func setUI() {
        view.backgroundColor = .white000
        nicknameLabel.do {
            $0.text = "\(nickname)님 안녕하세요 :)"
            $0.font = .fontGuide(.heading2_kor)
        }
        myProjectTableView.do {
            $0.separatorStyle = .none
        }
    }
    
    private func setLayout() {
        view.addSubviews(nicknameLabel, myProjectTableView)
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(32)
            $0.leading.equalToSuperview().inset(24)
        }
        
        myProjectTableView.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setDelegate() {
        myProjectTableView.delegate = self
        myProjectTableView.dataSource = self
    }
    
    private func setRegister() {
        myProjectTableView.registerCell(MyProjectTableViewCell.self)
    }
    
    private func setNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: Image.notification,
            style: .plain,
            target: self,
            action: #selector(notificationButtonTapped)
        )
        
        navigationItem.rightBarButtonItem?.tintColor = .gray500
        
        let title = "내 프로젝트"
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.black000,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]
        
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.attributedText = NSAttributedString(string: title, attributes: attributes)
        } else {
            let titleLabel = UILabel()
            titleLabel.attributedText = NSAttributedString(string: title, attributes: attributes)
            navigationItem.titleView = titleLabel
        }
    }
    
    private func setTarget() { }
}

extension MyProjectViewController {
    @objc
    private func notificationButtonTapped() { }
}

extension MyProjectViewController: UITableViewDelegate { }

extension MyProjectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyProjectData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(type: MyProjectTableViewCell.self, indexPath: indexPath)
        cell.setDataBind(MyProjectData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
}
