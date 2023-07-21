//
//  HomeBottomSheetTableViewCell.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/19.
//

import UIKit

final class HomeBottomSheetTableViewCell: UITableViewCell {
    
    // MARK: - UI Components
    
    private let projectTitleLabel = UILabel()
    private let selectedDotView = UIImageView()
    
    // MARK: - Properties

    typealias ProjectId = Int?
    private var projectTitle: String? = nil
    private var projectId: ProjectId = nil
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        projectTitleLabel.text = nil
        selectedDotView.isHidden = true
        self.backgroundColor = .gray200
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeBottomSheetTableViewCell {
    
    // MARK: - UI Components Property

    private func setUI() {
        self.backgroundColor = .gray200
        
        projectTitleLabel.do {
            $0.font = .fontGuide(.body1_bold_kor)
            $0.textColor = .gray600
        }
        
        selectedDotView.do {
            $0.image = Image.point
            $0.isHidden = true
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        self.addSubviews(projectTitleLabel, selectedDotView)
        
        projectTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        selectedDotView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}

extension HomeBottomSheetTableViewCell {
    
    // MARK: - Methods
    
    func setDataBind(project: OngoingProjectData, isCurrentProject: Bool) {
        projectTitleLabel.text = project.projectName
        projectTitle = project.projectName
        projectId = project.projectId
        if isCurrentProject != false {
            selectedDotView.isHidden = false
            self.backgroundColor = .white000
        }
    }
    
    func getServiceParameter() -> ProjectId {
        guard let projectId else {
            fatalError("Cell Doesn't have intact Information.")
        }
        return projectId
    }
}
