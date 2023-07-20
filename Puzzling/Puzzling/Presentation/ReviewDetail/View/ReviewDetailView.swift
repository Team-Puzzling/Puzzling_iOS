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
    private var reviewDetailData: [ReviewDetailModel] = []
    private var selectedDate: String = "2023-07-17"
    
    private func findMyData() -> ReviewDetailModel {
        var data: ReviewDetailModel = ReviewDetailModel(reviewId: nil, reviewDay: "", reviewDate: "", reviewTemplateId: nil, contents: nil)
        reviewDetailData.forEach {
            
                print("👥👥👥👥👥👥👥👥👥👥👥👥👥👥👥")
            if($0.reviewDate == selectedDate) {
                data = $0
                print(data)
            }
        }
        return data
    }
    
    let reviewCollectionview = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        setDelegate()
        setRegister()
        setNotificationCenter()
        self.backgroundColor = .systemRed
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
    
    func setNotificationCenter() {
        print("plz")
        NotificationCenter.default.addObserver(self, selector: #selector(getDateNotification(_:)), name: Notification.Name("dateNotification"), object: nil)
//        reviewCollectionview.reloadData()
    }
}

extension ReviewDetailView {
    func setDataBind(data: [ReviewDetailModel]) {
        self.reviewDetailData = data
        self.reviewCollectionview.reloadData()
    }
}

extension ReviewDetailView {
    @objc
    private func getDateNotification(_ notification: Notification) {
        print(#function)
        let dateNotification = notification.userInfo?["userInfo"]
        selectedDate = dateNotification as! String
//        calendarView.select(dateFormatter.date(from: selectedDate))
        print(selectedDate)
        print(dateNotification ?? "","?slsllslslslls??")
        selectedDate = dateNotification as! String
        print(selectedDate,"✅✅✅✅??✅✅")
        reviewCollectionview.reloadData()
    }
}

extension ReviewDetailView: UICollectionViewDelegate { }

extension ReviewDetailView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var data = findMyData()
        guard let count = data.contents?.count else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = reviewCollectionview.dequeueCell(type: ReviewDetailCollectionViewCell.self, indexPath: indexPath)
//        setNotificationCenter()
            print(selectedDate,"ㅋㅋ???ㅋㅋㅋ")
//        reviewDetailData.forEach {
        var data = findMyData()
        print(data)
            if(data.reviewDate == selectedDate) {
                guard let title = data.contents?[indexPath.row].title else { return UICollectionViewCell() }
                guard let description = data.contents?[indexPath.row].content else { return UICollectionViewCell() }
                cell.setDataBind(title: title, description: description)
                guard let count = data.contents?.count else { return UICollectionViewCell() }
                if (indexPath.row == count - 1) {
                    cell.divisionHidden()
                }
            }
//        }
        
        return cell
    }
}

extension ReviewDetailView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var data = findMyData()
        guard let height = data.contents?[indexPath.row].content.textHeight(withWidth: UIScreen.main.bounds.width - 64) else { return CGSize(width: 0, height: 0) }
        return CGSize(width: UIScreen.main.bounds.width, height: height + 56)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 120)
    }
}
