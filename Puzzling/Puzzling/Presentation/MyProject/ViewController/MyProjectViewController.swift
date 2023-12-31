//
//  MyProjectViewController.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/12.
//

import UIKit

import SnapKit
import Then
import Moya

final class MyProjectViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let myProjectTableView = UITableView(frame: .zero, style: .grouped)
    
    // MARK: - Properties
    
    private let myProjectProvider = MoyaProvider<MyProjectService>(plugins:[NetworkLoggerPlugin()])
    private var myProjectData: [ProjectListResponse] = []
    private var currentProjectId: Int = 0
    private var currentProjectTitle: String = ""
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setDelegate()
        setRegister()
        fetchProjectList()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    deinit {
        print(className)
    }
}

extension MyProjectViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        view.backgroundColor = .white000
        myProjectTableView.do {
            $0.separatorStyle = .none
            $0.backgroundColor = .clear
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        view.addSubviews(myProjectTableView)

        myProjectTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    private func setDelegate() {
        myProjectTableView.delegate = self
        myProjectTableView.dataSource = self
    }
    
    private func setRegister() {
        myProjectTableView.registerCell(MyProjectTableViewCell.self)
        myProjectTableView.registerReusableView(MyProjectTableHeaderView.self)
    }
    
    private func setNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: Image.notification,
            style: .plain,
            target: self,
            action: #selector(notificationButtonTapped)
        )
        
        navigationItem.rightBarButtonItem?.tintColor = .gray500
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
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
}

extension MyProjectViewController {
    
    // MARK: - @objc Methods
    @objc
    private func notificationButtonTapped() { }
    
}

extension MyProjectViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myProjectData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(type: MyProjectTableViewCell.self, indexPath: indexPath)
        cell.delegate = self
        cell.delegateVC = self
        cell.setDataBind(myProjectData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableView(type: MyProjectTableHeaderView.self)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 82
    }
}

extension MyProjectViewController: MyProjectPassEventDelegate, MyProjectSwitchTabDelegate {
    func passTouchEvent(newProject: Int) {
        self.tabBarController?.selectedIndex = 0
        UserDefaults.standard.setValue(newProject, forKey: "projectId")
    }
    
    func passTouchEvent(projectTitle: String, projectId: Int) {
        self.currentProjectTitle = projectTitle
        self.currentProjectId = projectId
        let vc = MyReviewListViewController()
        vc.passData(id: self.currentProjectId, title: self.currentProjectTitle)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func passReviewButton() {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Network
    
    private func fetchProjectList() {
        guard let memberId = UserDefaults.standard.string(forKey: "memberId") else { return }
        myProjectProvider.request(.projectList(memberId: memberId)) { result in
            switch result {
            case .success(let result):
                let status = result.statusCode
                print(status)
                if status >= 200 && status < 300 {
                    do {
                        guard let data = try result.map(GeneralResponse<[ProjectListResponse]>.self).data else { return }
                        self.myProjectData = data
                        self.myProjectTableView.reloadData()
                        print("♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️")
                    } catch(let error) {
                        print(error.localizedDescription)
                    }
                } else if status == 404 {
                    print("💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
