//
//  ReviewDetailView.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/15.
//

import UIKit

import SnapKit
import Then

final class ReviewDetailView: UIView {
    var ddddd = 0
    private let reviewDetailData = ReviewDetailDataModel.dummy()
    private var selectedDate: String = ""
    
//    func findMyData() -> ReviewDetailDataModel {
//        var data: ReviewDetailDataModel
//        reviewDetailData.forEach {
//            if($0.reviewDate == selectedDate) {
//                data = $0
//            }
//        }
//        return data
//    }
    
    private let reviewCollectionview = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        setDelegate()
        setRegister()
        setNotificationCenter()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        print(className)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("dateNotification"), object: nil)
    }
    
    deinit {
        print(className)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("dateNotification"), object: nil)
    }
}

extension ReviewDetailView {
    private func setUI() {
        reviewCollectionview.do {
            $0.contentInsetAdjustmentBehavior = .never
            $0.showsVerticalScrollIndicator = false
        }
    }
    
    private func setLayout() {
        self.addSubviews(reviewCollectionview)
        
        reviewCollectionview.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setDelegate() {
        reviewCollectionview.dataSource = self
        reviewCollectionview.delegate = self
    }
    
    private func setRegister() {
        reviewCollectionview.registerCell(ReviewDetailCollectionViewCell.self)
    }
    
    private func setNotificationCenter() {
        print("plz")
        NotificationCenter.default.addObserver(self, selector: #selector(getDateNotification(_:)), name: Notification.Name("dateNotification"), object: nil)
        ddddd += 1
        print(ddddd)
    }
}

extension ReviewDetailView {
    @objc
    private func getDateNotification(_ notification: Notification) {
        let dateNotification = notification.userInfo?["userInfo"]
        print(dateNotification ?? "","?slsllslslslls??")
        selectedDate = dateNotification as! String
        print(selectedDate)
    }
}

extension ReviewDetailView: UICollectionViewDelegate { }

extension ReviewDetailView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = reviewDetailData[1].contents?.count else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = reviewCollectionview.dequeueCell(type: ReviewDetailCollectionViewCell.self, indexPath: indexPath)
            print(selectedDate,"ㅋㅋㅋㅋㅋ")
        reviewDetailData.forEach {
            if($0.reviewDate == selectedDate) {
                guard let title = $0.contents?[indexPath.row].title else { return }
                guard let description = $0.contents?[indexPath.row].content else { return }
                cell.setDataBind(title: title, description: description)
                guard let count = $0.contents?.count else { return }
                if (indexPath.row == count - 1) {
                    cell.divisionHidden()
                }
            }
        }
        
        return cell
    }
}

extension ReviewDetailView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let height = reviewDetailData[1].contents?[indexPath.row].content.textHeight(withWidth: UIScreen.main.bounds.width - 64) else { return CGSize(width: 0, height: 0) }
        return CGSize(width: UIScreen.main.bounds.width, height: height + 56)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 120)
    }
}
