//
//  CreateProjectView.swift
//  Puzzling
//
//  Created by KJ on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class CreateProjectView: UIScrollView {
    
    // MARK: - UI Components
    
    private let createProjectStackView = UIStackView()
    private let nameView = InputContentView(type: .name)
    private let descriptionView = InputContentView(type: .description)
    private let startDayView = StartDayView()
    private let roleView = InputContentView(type: .role)
    private let nicknameView = InputContentView(type: .nickname)
    private let projectCycleView = UIView()
    private let projectCycleTitleLabel = UILabel()
    private let projectCycleDescriptionLabel = UILabel()
    private lazy var cycleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    private let projectCycleModel: [ProjectCycleModel] = ProjectCycleModel.projectCycleModelData()
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        setDelegate()
        setRegister()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CreateProjectView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        backgroundColor = .white000
        
        createProjectStackView.do {
            $0.axis = .vertical
            $0.distribution = .fill
            $0.alignment = .fill
            $0.spacing = 16
        }
        
        projectCycleTitleLabel.do {
            $0.text = "회고 주기"
            $0.font = .fontGuide(.body1_bold_kor)
            $0.textColor = .black000
        }
        
        projectCycleDescriptionLabel.do {
            $0.text = "회고는 매주 반복되며, 중복 체크가 가능해요."
            $0.font = .fontGuide(.detail2_regular_kor)
            $0.textColor = .gray600
        }
        
        cycleCollectionView.do {
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        projectCycleView.addSubviews(projectCycleTitleLabel, projectCycleDescriptionLabel, cycleCollectionView)
        createProjectStackView.addArrangedSubviews(nameView, descriptionView, startDayView,
                                                   roleView, nicknameView, projectCycleView)
        addSubviews(createProjectStackView)
        
        createProjectStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            $0.bottom.equalToSuperview().inset(21)
        }
        
        nameView.snp.makeConstraints {
            $0.height.equalTo(106)
        }
        
        descriptionView.snp.makeConstraints {
            $0.height.equalTo(nameView)
        }
        
        startDayView.snp.makeConstraints {
            $0.height.equalTo(74)
        }
        
        roleView.snp.makeConstraints {
            $0.height.equalTo(nameView)
        }
        
        nicknameView.snp.makeConstraints {
            $0.height.equalTo(nameView)
        }
        
        projectCycleView.snp.makeConstraints {
            $0.height.equalTo(102)
        }
        
        projectCycleTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(8)
            $0.height.equalTo(24)
        }
        
        projectCycleDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(projectCycleTitleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(projectCycleTitleLabel)
            $0.height.equalTo(18)
        }
        
        cycleCollectionView.snp.makeConstraints {
            $0.top.equalTo(projectCycleDescriptionLabel.snp.bottom).offset(8)
            $0.width.equalTo(343)
            $0.height.equalTo(48)
        }
    }
    
    // MARK: - Methods
    
    private func setDelegate() {
        cycleCollectionView.delegate = self
        cycleCollectionView.dataSource = self
    }
    
    private func setRegister() {
        cycleCollectionView.registerCell(ProjectCycleCollectionViewCell.self)
    }
    
    // MARK: - @objc Methods
}

extension CreateProjectView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 48
        let height = 48
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

extension CreateProjectView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return projectCycleModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(type: ProjectCycleCollectionViewCell.self, indexPath: indexPath)
        cell.setDataBind(model: projectCycleModel[indexPath.row])
        return cell
    }
}