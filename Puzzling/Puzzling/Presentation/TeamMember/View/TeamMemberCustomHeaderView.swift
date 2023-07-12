//
//  TeamMemberCustomHeader.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/11.
//

import UIKit

import Then
import SnapKit

class TeamMemberCustomHeaderView: UITableViewHeaderFooterView {
    
    static let identifier = "sectionHeader"
    let title = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setLayout()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        title.do {
            $0.textColor = .black000
            $0.font = .fontGuide(.body1_bold_kor)
        }
    }
    
    func setLayout() {
        title.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(title)
        
        title.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(16)
        }
    }
}
