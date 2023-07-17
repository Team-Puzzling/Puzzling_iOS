//
//  ActionPlanView.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class ActionPlanView: UIView {
    
    private let headerLabel = UILabel()
    private lazy var actionPlanCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: setFlowLayout())
    
    private var actionPlanData: [ActionPlan] = [ActionPlan(actionPlanContent: "여기에는 글이 계속 작성되다가 작성되다가 작성되다가 작성되다가 이쯤 되면 끊기게 돼되면 끊기게 돼되면 끊기게 돼되면 끊기게 돼", actionPlanDate: "2023-06-19"), ActionPlan(actionPlanContent: "여기에는 글이 계속 작성되다가 작성되다가 작성되다가 작성되다가 이쯤 되면 끊기게 돼되면 끊기게 돼되면 끊기게 돼되면 끊기게 돼", actionPlanDate: "2023-04-29"), ActionPlan(actionPlanContent: "여기에는 글이 계속 작성되다가 작성되다가 작성되다가 작성되다가 이쯤 되면 끊기게 돼되면 끊기게 돼되면 끊기게 돼되면 끊기게 돼", actionPlanDate: "2023-02-05"), ActionPlan(actionPlanContent: "여기에는 글이 계속 작성되다가 작성되다가 작성되다가 작성되다가 이쯤 되면 끊기게 돼되면 끊기게 돼되면 끊기게 돼되면 끊기게 돼", actionPlanDate: "2023-04-19")]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDelegate()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ActionPlanView {

    private func setDelegate() {
        actionPlanCollectionView.delegate = self
        actionPlanCollectionView.dataSource = self
    }
    
    private func setUI() {
        headerLabel.do {
            $0.text = "ACTION PLAN"
            $0.font = .fontGuide(.body1_bold_kor)
            $0.textColor = .black000
        }
        
        actionPlanCollectionView.do {
            $0.registerCell(ActionPlanCollectionViewCell.self)
            $0.isScrollEnabled = true
            $0.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = .clear
        }
    }
    
    private func setLayout() {
        self.addSubviews(headerLabel, actionPlanCollectionView)
        
        headerLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        actionPlanCollectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(headerLabel.snp.bottom).offset(16)
            $0.height.equalTo(160)
        }
    }
    
    // Change the layout setting to Compositional Layout later.
    private func setFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let width: CGFloat = UIScreen.main.bounds.width / 2.4
        let height: CGFloat = UIScreen.main.bounds.height / 5.8
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .horizontal
        return layout
    }
}

extension ActionPlanView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if actionPlanData.isEmpty {
            return 1
        }
        
        return actionPlanData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(type: ActionPlanCollectionViewCell.self, indexPath: indexPath)
        
        if actionPlanData.isEmpty {
            cell.setCellWhenEmpty()
            return cell
        }
        
        let dataHead = actionPlanData[indexPath.item]
        cell.setDataBind(dateString: dataHead.actionPlanDate, content: dataHead.actionPlanContent)
        return cell
    }
}
