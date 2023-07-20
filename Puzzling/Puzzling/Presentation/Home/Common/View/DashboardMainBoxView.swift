//
//  IndivisualMainView.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/12.
//

import UIKit

import SnapKit
import Then

enum DashboardType {
    case indivisual
    case team
    
    var cardButtonTitle: String {
        switch self {
        case .indivisual:
            return "퍼즐판 보러가기"
        case .team:
            return "팀 퍼즐판 보러가기"
        }
    }
    
    var identifier: String {
        switch self {
        case .indivisual:
            return "indivisual"
        case .team:
            return "team"
        }
    }
    
    var navigationTitle: String {
        switch self {
        case .indivisual:
            return "내 퍼즐판"
        case .team:
            return "팀 퍼즐판"
        }
    }
}

final class DashboardMainBoxView: UIView {
    
    private var userName: String = "User" {
        didSet {
            userNameLabel.text = "\(userName)님이 모은 퍼즐"
        }
    }
    
    private var piecesCount: Int = 0 {
        didSet {
            piecesCountLabel.text = "\(piecesCount % 15) 조각"
        }
    }
    
    private let puzzleViewHeight = UIScreen.main.bounds.height / 7.12
    private let cardButtonHeight = UIScreen.main.bounds.height / 14
    
    private let userNameLabel = UILabel()
    private let piecesCountLabel = UILabel()
    private let maxCountLabel = UILabel()
    lazy var puzzleCollectionView = MainPuzzleCollectionView(frame: .zero, dashboardType: puzzleBoardType)
    private lazy var cardButtonView = IndivisualCardButtonView(frame: .zero, cardTitle: boxType.cardButtonTitle)
    
    private var boxType: DashboardType!
    private var puzzleBoardType: DashboardType!
    
    init(frame: CGRect, type: DashboardType) {
        self.boxType = type
        self.puzzleBoardType = type
        super.init(frame: frame)
        setDelegate()
        setUI()
        setLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
 
extension DashboardMainBoxView {
    
    private func setDelegate() {
        
    }
    
    private func setUI() {
        self.backgroundColor = .blue50
        
        userNameLabel.do {
            $0.font = .fontGuide(.heading4_kor)
            $0.textColor = .black000
        }
        
        piecesCountLabel.do {
            $0.font = .fontGuide(.heading4_kor)
            $0.textColor = .blue400
            $0.textAlignment = .right
        }
        
        maxCountLabel.do {
            $0.text = "/15"
            $0.font = .fontGuide(.detail1_regular_kor)
            $0.textColor = .gray500
        }
    }
    
    private func setLayout() {
        self.addSubviews(userNameLabel, maxCountLabel, piecesCountLabel, puzzleCollectionView, cardButtonView)
        
        userNameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(24)
        }
        
        maxCountLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(29)
            $0.top.equalToSuperview().inset(30)
        }
        
        piecesCountLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.trailing.equalTo(maxCountLabel.snp.leading).offset(-6)
        }
        
        puzzleCollectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(puzzleViewHeight)
            $0.top.equalTo(userNameLabel.snp.bottom).offset(10)
        }
        
        cardButtonView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(18)
            $0.height.equalTo(cardButtonHeight)
        }
    }
}

extension DashboardMainBoxView {
    func passPuzzleData(userName: String, piecesCount: Int, totalPuzzleBoardCount: Int, dashboardData: [ModelProtocol]) {
        self.userName = userName
        self.piecesCount = piecesCount
        self.cardButtonView.passBoardCount(count: totalPuzzleBoardCount)
        self.puzzleCollectionView.passPuzzleData(data: dashboardData)
    }
    
    func reloadPuzzleView() {
        self.puzzleCollectionView.reloadCollectionView()
    }
}

