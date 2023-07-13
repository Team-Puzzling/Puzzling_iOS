//
//  MyReviewListViewController.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/13.
//

import UIKit

import SnapKit
import Then

final class MyReviewListViewController: UIViewController {

    private let myReviewListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let myReviewListData = MyReviewListDataModel.dummy()
    
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

extension MyReviewListViewController {
    @objc
    private func notificationButtonTapped() { }
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
}

extension MyReviewListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width-32, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 12, right: 16)
    }
}
