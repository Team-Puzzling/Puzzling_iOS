//
//  MainPuzzleCollectionView.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/16.
//

import UIKit

import SnapKit
import Then

final class MainPuzzleCollectionView: UIView {

    private lazy var puzzleCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.setFlowLayout())
    private var modelType: ModelProtocol.Type!
    private var modelData: [ModelProtocol?] = []
    private var dashboardType: DashboardType
    
    private let cellHeight: CGFloat = UIScreen.main.bounds.height / 9.2
    private let cellWidth: CGFloat = UIScreen.main.bounds.width / 5.86
    
    init(frame: CGRect, dashboardType: DashboardType) {
        self.dashboardType = dashboardType
        super.init(frame: frame)
        setDelegate()
        setUI()
        setLayout()
        setRegister()
        print("opopopop")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainPuzzleCollectionView {
    
    private func setDelegate() {
        puzzleCollectionView.dataSource = self
        puzzleCollectionView.delegate = self
    }
    
    private func setUI() {
        self.backgroundColor = .clear
        puzzleCollectionView.do {
            $0.isScrollEnabled = true
            $0.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
            $0.showsHorizontalScrollIndicator = true
            $0.backgroundColor = .clear
        }
        print("6️⃣")
    }
    
    private func setLayout() {
        self.addSubviews(puzzleCollectionView)
        
        puzzleCollectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.verticalEdges.equalToSuperview().inset(5)
        }
        print("🔸")
    }
    
    private func setRegister() {
        if self.modelType == IndivisualPuzzleStatusModel.self {
            puzzleCollectionView.registerCell(MainPuzzleCollectionViewCell<IndivisualPuzzleStatusModel>.self)
        } else if self.modelType == TeamPuzzleStatusModel.self {
            puzzleCollectionView.registerCell(MainPuzzleCollectionViewCell<TeamPuzzleStatusModel>.self)
        }
        print("5️⃣")
    }
}

extension MainPuzzleCollectionView {
    private func setFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        return layout
    }
}

extension MainPuzzleCollectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("tyutyu")
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("qqqqqq")
        switch dashboardType {
        case .indivisual:
            let cell = collectionView.dequeueCell(type: MainPuzzleCollectionViewCell<IndivisualPuzzleStatusModel>.self, indexPath: indexPath)
            guard let model = modelData as? [IndivisualPuzzleStatusModel] else { return UICollectionViewCell() }
            cell.setDataBind(data: model[indexPath.item], index: indexPath.item)
            print("!!!!")
            return cell
        case .team:
            let cell = collectionView.dequeueCell(type: MainPuzzleCollectionViewCell<TeamPuzzleStatusModel>.self, indexPath: indexPath)
            guard let model = modelData as? [TeamPuzzleStatusModel] else { return UICollectionViewCell() }
            cell.setDataBind(data: model[indexPath.item], index: indexPath.item)
            print("!??!")
            return cell
        }
    }
}

extension MainPuzzleCollectionView {
    func passPuzzleData(data: [ModelProtocol?]) {
        let restOfDataCount = 15 - data.count
        if restOfDataCount == 0 {
            self.modelData = data
        }
        
        if data is [IndivisualPuzzleStatusModel?] {
            self.modelData = data + Array(repeating: nil, count: restOfDataCount)
            self.modelType = IndivisualPuzzleStatusModel.self
        } else if data is [TeamPuzzleStatusModel?] {
            self.modelData = data + Array(repeating: nil, count: restOfDataCount)
            self.modelType = TeamPuzzleStatusModel.self
        }
        
        print("pppp>?!")
    }
}
