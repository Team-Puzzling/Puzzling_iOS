//
//  ReviewDetailScrollView.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/17.
//

import UIKit

import SnapKit
import Then



final class ReviewDetailScrollView: UIScrollView {
    
    private let reviewDetailData = ReviewDetailDataModel.dummy()
    // MARK: - UI Components
    
    private let reviewStackView = UIStackView()
    
    private let firstView = ReviewDetailCustomView()
    private let secondView = ReviewDetailCustomView()
    private let thirdView = ReviewDetailCustomView()
    private let fourthView = ReviewDetailCustomView()
    private let fifthView = ReviewDetailCustomView()
    
    // MARK: - Properties
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ReviewDetailScrollView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        backgroundColor = .white000
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        reviewStackView.addArrangedSubviews(firstView, secondView, thirdView, fourthView, fifthView)
        addSubviews(reviewStackView)
        
        reviewStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(32)
            $0.bottom.equalToSuperview()
        }
        
        firstView.snp.makeConstraints {
            $0.height.equalTo(100)
        }
        
        secondView.snp.makeConstraints {
            $0.height.equalTo(100)
        }
        
        thirdView.snp.makeConstraints {
            $0.height.equalTo(100)
        }
        
        fourthView.snp.makeConstraints {
            $0.height.equalTo(100)
        }
        
        fifthView.snp.makeConstraints {
            $0.height.equalTo(100)
        }
    }
    
    // MARK: - Methods
    
    private func cycleNotification(list: [Int]) {
        let userInfo = list
        NotificationCenter.default.post(
            name: Notification.Name("cycleNotification"),
            object: nil,
            userInfo: ["userInfo": userInfo]
        )
    }
    
    private func setDatabind() {
        
    }
}
