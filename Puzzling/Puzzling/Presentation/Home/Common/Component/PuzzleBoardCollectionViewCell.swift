//
//  PuzzleBoardCollectionViewCell.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/20.
//

import UIKit

import SnapKit
import Then

struct PuzzleBoardData {
    var date: String
    var imageName: String
}

final class PuzzleBoardCollectionViewCell: UICollectionViewCell {
    
    private let dateLabel = UILabel()
    private let puzzleImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PuzzleBoardCollectionViewCell {
    
    private func setUI() {
        dateLabel.do {
            $0.font = .fontGuide(.body2_bold_kor)
            $0.textColor = .gray700
        }
        
        puzzleImageView.do {
            $0.contentMode = .scaleAspectFit
        }
    }
    
    private func setLayout() {
        self.addSubviews(dateLabel, puzzleImageView)
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(28)
            $0.top.equalToSuperview()
        }
        
        puzzleImageView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(dateLabel.snp.bottom).offset(8)
            $0.height.equalTo(puzzleImageView.snp.width).dividedBy(1.55)
        }
    }
}

extension PuzzleBoardCollectionViewCell {
    func passPuzzleInformation(dateString: String, puzzleImageName: String) {
        self.dateLabel.text = dateString
        self.puzzleImageView.image = UIImage(named: puzzleImageName)
    }
}
