//
//  MainPuzzleCollectionViewCell.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/16.
//

import UIKit

final class MainPuzzleCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    private let puzzleImageView = UIImageView()
    private let dateLabel = UILabel()
    
    // MARK: - Properties
    
    var reviewId: Int? = nil
    var cellDate: String? = nil
    var todayDate = Date().dateToServerString
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text = nil
        dateLabel.textColor = .blue500
        puzzleImageView.image = nil
        reviewId = nil
        cellDate = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainPuzzleCollectionViewCell {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        puzzleImageView.do {
            $0.contentMode = .scaleAspectFit
        }
        
        dateLabel.do {
            $0.font = .fontGuide(.detail2_regular_kor)
            $0.textColor = .blue500
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        self.addSubviews(puzzleImageView, dateLabel)
        
        puzzleImageView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(puzzleImageView.snp.width)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(puzzleImageView.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
    }
}

extension MainPuzzleCollectionViewCell {
    
    // MARK: - Methods
    
    /// IndivisualDashboard 에서 사용합니다.
    func setDataBind(data: UserPuzzleBoard, isTodayReviewed: Bool) {
        // 완성했는지를 boolean 으로 받자.
        let puzzleImageName = data.puzzleAssetName
        self.puzzleImageView.image = UIImage(named: puzzleImageName)
        
        guard let date = data.reviewDate else { return }
        
        let dateModified: String = date.convertDateToSlashFormat()
        self.cellDate = date
        
        if self.todayDate == date {
            jumpPuzzleAnimation()
        }
        
        if self.todayDate == date && isTodayReviewed == false {
            self.puzzleImageView.image = UIImage(named: puzzleImageName)
            self.dateLabel.text = dateModified
            self.dateLabel.textColor = .yellow500
            return
        }
        
        self.dateLabel.text = dateModified
        
        guard let reviewId = data.reviewId else { return }
        self.reviewId = reviewId
    }
    
    /// TeamDashboard 에서 사용합니다.
    func setDataBind(data: TeamPuzzleBoard, index: Int) {
        let puzzleImageName = data.puzzleAssetName
        self.puzzleImageView.image = UIImage(named: puzzleImageName)

        guard let date = data.reviewDate else {
            return
        }
        guard let _ = data.reviewMemberPercent else { return }
        
        let dateModified: String = date.convertDateToSlashFormat()
        self.cellDate = date
        
        if self.todayDate == date {
            self.puzzleImageView.image = UIImage(named: puzzleImageName)
            self.dateLabel.text = dateModified
            self.dateLabel.textColor = .yellow500
            return
        }
        
        self.dateLabel.text = dateModified
        self.dateLabel.textColor = .blue500
    }
    
    private func jumpPuzzleAnimation() {
        let jumpAnimation = CAKeyframeAnimation(keyPath: "position.y")
        jumpAnimation.values = [0, -10, 5, -4, 3, 0]
        jumpAnimation.keyTimes = [0, 0.15, 0.22, 0.34, 0.5, 0.55]
        jumpAnimation.duration = 0.55
        jumpAnimation.repeatCount = 2
        jumpAnimation.fillMode = .forwards
        jumpAnimation.isRemovedOnCompletion = false
        jumpAnimation.isAdditive = true
        self.puzzleImageView.layer.add(jumpAnimation, forKey: "jumpOnce")
    }
}

