//
//  MyReviewListViewController.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/14.
//

import UIKit

import SnapKit
import Then

final class MyReviewListViewController: UIViewController {
    
    private var currentProject: String = "Project1"
    
    private let myReviewListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let myReviewListData = MyReviewListDataModel.dummy()
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setDelegate()
        setRegister()
    }
    
    deinit {
        print(className)
    }
}

extension MyReviewListViewController {
    
    private func setUI() {
        view.backgroundColor = .white000
        
        myReviewListCollectionView.do {
            $0.contentInsetAdjustmentBehavior = .never
            $0.collectionViewLayout = UICollectionViewFlowLayout()
            $0.showsVerticalScrollIndicator = false
        }
    }
    
    private func setLayout() {
        view.addSubviews(myReviewListCollectionView)
        
        myReviewListCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setDelegate() {
        myReviewListCollectionView.delegate = self
        myReviewListCollectionView.dataSource = self
    }
    
    private func setRegister() {
        myReviewListCollectionView.registerCell(MyReviewListCollectionViewCell.self)
        myReviewListCollectionView.registerHeader(ProjectNameCollecionReusableView.self)
    }
    
    private func setNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: Image.leftIcon,
            style: .plain,
            target: self,
            action: #selector(leftChevronButtonTapped)
        )
        navigationItem.rightBarButtonItem?.tintColor = .gray500
        
        let title = currentProject
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
    
    private func reloadHeaderView(text: String) {
        guard let headerView = myReviewListCollectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0)) as? ProjectNameCollecionReusableView else { return }
        headerView.setDataBind(projectName: text)
    }
}

extension MyReviewListViewController {
    @objc
    private func leftChevronButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension MyReviewListViewController: projectNameProtocol {
    func nameData(text: String) {
        currentProject = text
        reloadHeaderView(text: text)
    }
}

extension MyReviewListViewController: buttonTappedProtocol {
    func passButtonEvent(projectName: String) {
        self.currentProject = projectName
        
        let vc = ProjectListViewController()
        vc.delegate = self
        vc.setProjectName(projectName: projectName)
        vc.modalPresentationStyle = .pageSheet
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        present(vc, animated: true, completion: nil)
    }
}

extension MyReviewListViewController: UICollectionViewDelegate { }

extension MyReviewListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        myReviewListData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myReviewListCollectionView.dequeueCell(type: MyReviewListCollectionViewCell.self, indexPath: indexPath)
        cell.setDataBind(myReviewListData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = myReviewListCollectionView.dequeueReusableCell(kind: UICollectionView.elementKindSectionHeader, type: ProjectNameCollecionReusableView.self, indexPath: indexPath)
        view.delegate = self
        view.setDataBind(projectName: currentProject)
        return view
    }
}

extension MyReviewListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width-32, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 12, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width-32, height: 82)
    }
}
