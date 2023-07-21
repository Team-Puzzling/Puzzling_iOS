//
//  ReviewDetailView.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/15.
//

import UIKit

import SnapKit
import Then

class DetailTypeView: UIView {
    func setDataBind(data: ReviewDetailModel) {}
}

final class ReviewDetailView: DetailTypeView {
    private var reviewDetailData: ReviewDetailModel = ReviewDetailModel(reviewId: nil, reviewDay: "", reviewDate: "", reviewTemplateId: nil, contents: nil)
    private var selectedDate: String = "2023-07-17"
    
    let reviewCollectionview = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        setDelegate()
        setRegister()
        self.backgroundColor = .systemRed
    }
    
    override func setDataBind(data: ReviewDetailModel) {
        self.reviewDetailData = data
        self.reviewCollectionview.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print(className)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("dateNotification"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("calendarToView"), object: nil)
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
}

extension ReviewDetailView {
    @objc
    private func getDateNotification(_ notification: Notification) {
        let dateNotification = notification.userInfo?["userInfo"]
        selectedDate = dateNotification as! String
        reviewCollectionview.reloadData()
    }
}

extension ReviewDetailView: UICollectionViewDelegate { }

extension ReviewDetailView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = reviewDetailData.contents?.count else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = reviewCollectionview.dequeueCell(type: ReviewDetailCollectionViewCell.self, indexPath: indexPath)
        print(reviewDetailData)
        
        guard let title = reviewDetailData.contents?[indexPath.row].title else { return UICollectionViewCell() }
        guard let description = reviewDetailData.contents?[indexPath.row].content else { return UICollectionViewCell() }
        cell.setDataBind(title: title, description: description)
        guard let count = reviewDetailData.contents?.count else { return UICollectionViewCell() }
        if (indexPath.row == count - 1) {
            cell.divisionHidden()
            
        }
        return cell
    }
}

extension ReviewDetailView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let height = reviewDetailData.contents?[indexPath.row].content.textHeight(withWidth: UIScreen.main.bounds.width - 64) else { return CGSize(width: 0, height: 0) }
        return CGSize(width: UIScreen.main.bounds.width, height: height + 56)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 120)
    }
}
