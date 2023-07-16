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
    
    private let reviewDetailData = ReviewDetailDataModel.dummy()
    private let reviewCollectionview = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var reviewLabelHeight: CGFloat = 0
    private var layout = UICollectionViewFlowLayout()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        setDelegate()
        setRegister()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ReviewDetailView {
    private func setUI() {
        backgroundColor = .systemBlue
        reviewCollectionview.do {
            $0.contentInsetAdjustmentBehavior = .never
            $0.collectionViewLayout = layout
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
    
    private func setLabelHeight() {
        NotificationCenter.default.addObserver(self, selector: #selector(labelHeightChanged(_:)), name: NSNotification.Name("LabelHeightNotification"), object: nil)
    }
    
}

extension ReviewDetailView {
    @objc func labelHeightChanged(_ notification: Notification) {
            if let labelHeight = notification.object as? CGFloat {
                print("Received label height: \(labelHeight)")
                reviewLabelHeight = labelHeight
            }
        }
}

extension ReviewDetailView: UICollectionViewDelegate { }

extension ReviewDetailView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviewDetailData[1].contents?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = reviewCollectionview.dequeueCell(type: ReviewDetailCollectionViewCell.self, indexPath: indexPath)
        guard let title = reviewDetailData[1].contents?[indexPath.row].title else { return UICollectionViewCell() }
        guard let description = reviewDetailData[1].contents?[indexPath.row].content else { return UICollectionViewCell() }
        cell.setDataBind(title: title, description: description)
        
        setLabelHeight()
        cell.sizeThatFits(CGSize(width: UIScreen.main.bounds.width-32, height: reviewLabelHeight+56))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        cell.sizeThatFits(CGSize(width: UIScreen.main.bounds.width-32, height: reviewLabelHeight+56))
//        collectionView.collectionViewLayout = layout
        collectionView.collectionViewLayout.invalidateLayout()
//        colleci
    }
}

extension ReviewDetailView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(reviewLabelHeight, "엥")
        
        return CGSize(width: UIScreen.main.bounds.width-32, height: reviewLabelHeight+56)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
}
