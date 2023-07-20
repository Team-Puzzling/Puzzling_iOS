//
//  MainPuzzleCollectionViewCell.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/16.
//

import UIKit

final class MainPuzzleCollectionViewCell: UICollectionViewCell {
    
    // 5.86 - width, 9.2 - height
    private let puzzleImageView = UIImageView()
    private let dateLabel = UILabel()
    var reviewId: Int? = nil
    
    var dateee: String? = "aaaaa"
    
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
        puzzleImageView.tintColor = .blue500
        reviewId = nil
        dateee = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainPuzzleCollectionViewCell {
    
    private func setUI() {
        puzzleImageView.do {
            $0.contentMode = .scaleAspectFit
        }
        
        dateLabel.do {
            $0.font = .fontGuide(.detail2_regular_kor)
            $0.textColor = .blue500
        }
    }
    
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
    func setDataBind(data: IndivisualPuzzleStatusModel?, index: Int) {
        if data == nil {
            // 아무 데이터가 없을때. index 사용해서 기본 에셋 사용
            self.puzzleImageView.image = UIImage(systemName: "puzzlepiece.extension")
            return
        }
        
        /// hasReviewed 는 여기가 아니라 APIService 에서 데이터 필터시에 필요할 것 같다.
        /// 그 이유는; 퍼즐에는 중간에 뻥 뚫린 퍼즐이 없을 것이기 때문이다.
        
        guard let reviewId = data?.reviewId,
              let hasReviewed = data?.status.hasReviewed,
              let date = data?.status.reviewDate,
              let isTodayReviewDay = data?.status.isTodayReviewDay
        else { return }
        let dateModified: String = date.convertDateToSlashFormat()
        self.reviewId = reviewId
        dateee = dateModified
        
        if isTodayReviewDay != false && hasReviewed == false {
            self.puzzleImageView.image = UIImage(systemName: "puzzlepiece.extension.fill")
            self.puzzleImageView.tintColor = .yellow500
            self.dateLabel.text = dateModified
            self.dateLabel.textColor = .yellow500
            print("YELLOW!!!")
            return
        }

        // 근데 그러면 본래의 rawData 에서 filter 로 hasReviewed = true 로만 바꿔서 가져와야하지 않나?? 그러면 굳이 더 필요하지 않잖아.
        
        self.puzzleImageView.image = UIImage(systemName: "puzzlepiece")
        self.dateLabel.text = dateModified
        
        //        switch hasReviewed {
        //        case true:
        //            // puzzleAssetNumber 로 받기? Int 활용하기?
        //            self.puzzleImageView.image = UIImage(systemName: "puzzlepiece")
        //            self.dateLabel.text = date
        //        case false:
        //            // index 로 받아온 Int 로 기본 이미지 박기
        //            self.puzzleImageView.image = UIImage(systemName: "puzzlepiece")
        //        }
    }
    
    func setDataBind(data: TeamPuzzleStatusModel?, index: Int) {
        if data == nil {
            // 아무 데이터가 없을때. index 사용해서 기본 에셋 사용
            self.puzzleImageView.image = UIImage(systemName: "puzzlepiece.extension")
            return
        }
        
        guard let date = data?.status.reviewDate,
              let hasReviewed = data?.status.hasReviewed,
              let isTodayReviewDay = data?.status.isTodayReviewDay,
              let percentage = data?.status.reviewedMemberPercentage
        else { return }
        let dateModified: String = date.convertDateToSlashFormat()
        dateee = dateModified
        
        if isTodayReviewDay != false && hasReviewed == false {
            self.puzzleImageView.image = UIImage(systemName: "puzzlepiece.extension.fill")
            self.dateLabel.text = dateModified
            self.dateLabel.textColor = .yellow500
            return
        }
        
        let imageName: String
        
        // Index 활용해야함, 현재는 그냥 분기처리
        switch percentage {
        case "A":
            imageName = "moonphase.waxing.crescent.inverse"
        case "B":
            imageName = "moonphase.first.quarter.inverse"
        case "C":
            imageName = "moonphase.waxing.gibbous.inverse"
        case "D":
            imageName = "moonphase.new.moon.inverse"
        default:
            return
        }
        
        self.puzzleImageView.image = UIImage(systemName: imageName)
        self.dateLabel.text = dateModified
        self.dateLabel.textColor = .blue500
        
        /// imageName 에 대한 기능이 구현됐을 때, 사용
        /// 지금 이렇게 계속 주석처리된 코드가 많은 것은 현재 프로젝트 내에 퍼즐 에셋이 들어있지 않기 때문이다.
        //        self.puzzleImageView.image = UIImage(named: imageName)
    }
}

