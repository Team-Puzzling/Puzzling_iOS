//
//  ActionPlanView.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/12.
//

import UIKit

import Moya
import SnapKit
import Then

final class ActionPlanView: UIView {
    
    // MARK: - UI Components
    
    private let headerLabel = UILabel()
    private lazy var actionPlanCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: setFlowLayout())
    
    // MARK: - Properties
    
    private let indivisualDashboardNetworkProvider = MoyaProvider<ProjectServiceKBS>(plugins: [NetworkLoggerPlugin(verbose: true)])
    private var actionPlanData: [ActionPlan] = []
    private var collectionViewHeight: CGFloat = UIScreen.main.bounds.height / 5.6
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDelegate()
        setUI()
        setLayout()
        setData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ActionPlanView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        headerLabel.do {
            $0.text = "ACTION PLAN"
            $0.font = .fontGuide(.heading4_kor)
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
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        self.addSubviews(headerLabel, actionPlanCollectionView)
        
        headerLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        actionPlanCollectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(headerLabel.snp.bottom).offset(16)
            $0.height.equalTo(collectionViewHeight)
        }
    }
    
    // MARK: - Methods
    
    private func setDelegate() {
        actionPlanCollectionView.delegate = self
        actionPlanCollectionView.dataSource = self
    }
    
    // MARK: - Network
    
    private func setData() {
        indivisualDashboardNetworkProvider.request(.fetchActionPlans(memberId: 1, projectId: 2)) { [weak self] response in
            switch response {
            case .success(let result):
                let status = result.statusCode
                switch status {
                case 200..<299:
                    guard let data = try? result.map(GeneralResponse<[ActionPlan]>.self).data else { return }
                    self?.actionPlanData = data
                    self?.actionPlanCollectionView.reloadData()
                case 400:
                    print(result.description)
                case 401:
                    print(result.description)
                case 404:
                    print(result.debugDescription)
                case 500:
                    print(result.description)
                default:
                    print("Other Errors")
                    break
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // Change the layout setting to Compositional Layout later.
    private func setFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .horizontal
        return layout
    }
}

extension ActionPlanView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if actionPlanData.isEmpty {
            print("Action Plan is Empty")
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
    
    // 이게 필요하려나?
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = UIScreen.main.bounds.width / 2.4
        let height: CGFloat = UIScreen.main.bounds.height / 5.8
        return CGSize(width: width, height: height)
    }
}

extension ActionPlanView {
    func passActionPlanView(data: [ActionPlan]) {
        self.actionPlanData = data
        self.actionPlanCollectionView.reloadData()
    }
}
