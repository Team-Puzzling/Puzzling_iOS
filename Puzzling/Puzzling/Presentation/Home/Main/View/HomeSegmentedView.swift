//
//  HomeSegmentedView.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/10.
//

import UIKit

import SnapKit
import Then

protocol HomeSegmentDelegate: AnyObject {
    func movePage(to index: Int)
}

final class HomeSegmentedView: UIView {

    private lazy var indivisualDashboardButton = UIButton(frame: .zero, primaryAction: moveToIndivisualAction())
    private lazy var teamDashboardButton = UIButton(frame: .zero, primaryAction: moveToTeamAction())
    
    private let backLineView = UIView()
    private let segmentedLineView = UIView()
    
    private var selectedIndex: Int = 0
    
    weak var delegate: HomeSegmentDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeSegmentedView {
    
    private func setUI() {
        indivisualDashboardButton.do {
            $0.setTitle("개인 대시보드", for: .normal)
            $0.titleLabel?.font = .fontGuide(.body1_bold_kor)
            $0.setTitleColor(selectedIndex == 0 ? .blue400: .gray400 , for: .normal)
        }
        
        teamDashboardButton.do {
            $0.setTitle("팀 대시보드", for: .normal)
            $0.titleLabel?.font = .fontGuide(.body1_bold_kor)
            $0.setTitleColor(selectedIndex == 0 ? .gray400: .blue400 , for: .normal)
        }
        
        backLineView.do {
            $0.backgroundColor = .gray300
        }
        
        segmentedLineView.do {
            $0.backgroundColor = .blue400
        }
    }
    
    private func setLayout() {
        self.addSubviews(indivisualDashboardButton, teamDashboardButton, backLineView, segmentedLineView)
        
        indivisualDashboardButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(2)
            $0.height.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        teamDashboardButton.snp.makeConstraints {
            $0.leading.equalTo(indivisualDashboardButton.snp.trailing)
            $0.width.equalToSuperview().dividedBy(2)
            $0.height.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        backLineView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview().inset(0.5)
        }
        
        segmentedLineView.snp.makeConstraints {
            $0.width.equalToSuperview().dividedBy(2)
            $0.height.equalTo(2)
            $0.bottom.equalToSuperview()
            $0.leading.equalTo(indivisualDashboardButton.snp.leading).inset(1)
        }
    }
}

extension HomeSegmentedView {
    private func moveToTeamAction() -> UIAction? {
        let action = UIAction(handler: { [weak self] _ in
            guard let index = self?.selectedIndex else { return }
            
            if index == 1 {
                return
            }
            
            self?.updateButton(index: index)
            self?.moveBarAction(index: index)
            self?.delegate?.movePage(to: index)
        })
        return action
    }
    
    private func moveToIndivisualAction() -> UIAction? {
        let action = UIAction(handler: { [weak self] _ in
            guard let index = self?.selectedIndex else { return }
            
            if index == 0 {
                return
            }
            
            self?.updateButton(index: index)
            self?.moveBarAction(index: index)
            self?.delegate?.movePage(to: index)
        })
        return action
    }
    
    private func moveBarAction(index: Int) {
        switch index {
        case 0:
            segmentedLineView.snp.remakeConstraints {
                $0.width.equalToSuperview().dividedBy(2)
                $0.height.equalTo(2)
                $0.bottom.equalToSuperview()
                $0.leading.equalTo(teamDashboardButton.snp.leading).inset(1)
            }
            
            UIView.animate(withDuration: 0.2) {
                self.layoutIfNeeded()
            }
            
            selectedIndex = 1
        case 1:
            segmentedLineView.snp.remakeConstraints {
                $0.width.equalToSuperview().dividedBy(2)
                $0.height.equalTo(2)
                $0.bottom.equalToSuperview()
                $0.leading.equalTo(indivisualDashboardButton.snp.leading).inset(1)
            }
            
            UIView.animate(withDuration: 0.2) {
                self.layoutIfNeeded()
            }
            
            selectedIndex = 0
        default:
            break
        }
    }
    
    private func updateButton(index: Int) {
        switch index {
        case 0:
            indivisualDashboardButton.setTitleColor(.gray400, for: .normal)
            teamDashboardButton.setTitleColor(.blue400, for: .normal)
        case 1:
            indivisualDashboardButton.setTitleColor(.blue400, for: .normal)
            teamDashboardButton.setTitleColor(.gray400, for: .normal)
        default:
            break
        }
    }
}
