//
//  MyProjectViewController.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/12.
//

import UIKit

import FSCalendar
import SnapKit
import Then

final class MyProjectViewController: UIViewController {
    
    private let nickname:String = "공듀"
    
    private let myProjectTableView = UITableView()
    
    private let nicknameLabel = UILabel()
    
    public let MyProjectData = MyProjectDataModel.dummy()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setUI()
        setLayout()
        setTarget()
        setDelegate()
        registerCell()
    }
    
    func setUI() {
        view.backgroundColor = .white000
        nicknameLabel.do {
            $0.text = "\(nickname)님 안녕하세요 :)"
            $0.font = .fontGuide(.heading2_kor)
        }
        myProjectTableView.do {
            $0.separatorStyle = .none
        }
    }
    
    func setLayout() {
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
    
    func setDelegate() {
        myProjectTableView.delegate = self
        myProjectTableView.dataSource = self
    }
    
    func registerCell() {
        myProjectTableView.register(MyProjectTableViewCell.self, forCellReuseIdentifier:  MyProjectTableViewCell.identifier)
    }
    
    private func setNavigationBar() {
        
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
    
    private func setTarget() {
        
    }
}

extension MyProjectViewController: UITableViewDelegate {}


extension MyProjectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(MyProjectData.count)
        return MyProjectData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyProjectTableViewCell.identifier, for: indexPath) as? MyProjectTableViewCell else { return UITableViewCell() }
        cell.configureCell(MyProjectData[indexPath.row])
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
}
