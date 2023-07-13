//
//  TeamMemberCustomHeader.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/11.
//

import UIKit

import Then
import SnapKit

final class TeamMemberCustomHeaderView: UITableViewHeaderFooterView {
    
    private let title = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setLayout()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        title.do {
            $0.textColor = .black000
            $0.font = .fontGuide(.body1_bold_kor)
        }
    }
    
    private func setLayout() {
        title.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(title)
        
        title.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(16)
        }
    }
}

extension TeamMemberCustomHeaderView {
    func setDataBind(section: Int) {
        switch section {
        case 0: title.text = "회고를 진행했어요"
        case 1: title.text = "회고를 진행해야 해요"
        default: title.text = ""
        }
    }
}
