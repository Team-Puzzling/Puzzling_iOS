//
//  ProjectNameTableViewCell.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/14.
//

import UIKit

import SnapKit
import Then

final class ProjectNameTableViewCell: UITableViewCell {
    
    // MARK: - UI Components
    
    private let nameLabel = UILabel()
    private let divisionLabel = UILabel()
    private let pointImageView = UIImageView()
    
    // MARK: - Properties
    
    private var name: String = "Project Name" {
        didSet {
            nameLabel.text = name
        }
    }
    private var id: Int = 0
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        nameLabel.text = ""
        contentView.backgroundColor = .background050
        pointImageView.isHidden = true
    }
}

extension ProjectNameTableViewCell {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        contentView.backgroundColor = .background050
        
        separatorInset.left = 0
        selectionStyle = .none
        
        nameLabel.do {
            $0.font = .fontGuide(.body1_bold_kor)
            $0.textColor = .gray600
        }
        
        divisionLabel.do {
            $0.backgroundColor = .gray200
        }
        
        pointImageView.do {
            $0.image = Image.point
            $0.isHidden = true
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        contentView.addSubviews(nameLabel, divisionLabel, pointImageView)
        
        nameLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(18)
            $0.leading.equalToSuperview().inset(16)
        }
        
        divisionLabel.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        pointImageView.snp.makeConstraints {
            $0.size.equalTo(20)
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
}

extension ProjectNameTableViewCell {
    
    // MARK: - Methods
    
    func setDataBind(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    func setPointLabel() {
        pointImageView.isHidden = false
        contentView.backgroundColor = .white000
    }
}
