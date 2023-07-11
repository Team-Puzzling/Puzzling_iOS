//
//  TeamMemberViewController.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/10.
//

import UIKit

import FSCalendar
import SnapKit
import Then

class TeamMemberViewController: UIViewController {
    
    private let teamMemberView = TeamMemberView()
    private let teamMemberTableView = UITableView()
    
    public let TeamMemberData = TeamMemberDataModel.dummy()
    
//    override func loadView() {
//        self.view = teamMemberView
//    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        setUI()
        setLayout()
        configureCalendar()
        setTarget()
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: Icon.leftIcon,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        let title = "프로젝트 1"
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.black000,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]
        
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.attributedText = NSAttributedString(string: title, attributes: attributes)
        } else {
            let titleLabel = UILabel()
            titleLabel.attributedText = NSAttributedString(string: title, attributes: attributes)
            navigationItem.titleView = titleLabel
        }
    }
    
    @objc
    func backButtonTapped() {
        let transition = CATransition().then {
            $0.duration = 0.25
            $0.type = .push
            $0.subtype = .fromLeft
            $0.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        }
        view.window?.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false)
        self.navigationController?.popViewController(animated: false)
    }
    
    func setUI() {
        teamMemberTableView.do {
            $0.backgroundColor = .white000
            $0.register(TeamMemberTableViewCell.self, forCellReuseIdentifier: TeamMemberTableViewCell.identifier)
            $0.rowHeight = 50
            $0.delegate = self
            $0.dataSource = self
        }
    }
    
    func setTarget() {
        teamMemberView.toggleButton.addTarget(self, action: #selector(tapToggleButton), for: .touchUpInside)
    }
    
    func setLayout() {
        view.addSubviews(teamMemberView, teamMemberTableView)
        teamMemberView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(32.0)
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.height.equalTo(150)
        }
        
        teamMemberTableView.snp.makeConstraints {
            $0.top.equalTo(teamMemberView.snp.bottom).offset(500)
            $0.leading.trailing.equalToSuperview()
        }
    }
}

extension TeamMemberViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        print(bounds.height)
        teamMemberView.calendarView.snp.updateConstraints {
            $0.height.equalTo(bounds.height)
        }
        
        teamMemberView.snp.updateConstraints {
            $0.height.equalTo(bounds.height)
        }
        
        self.view.layoutIfNeeded()
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let currentPage = teamMemberView.calendarView.currentPage
        teamMemberView.headerLabel.text = teamMemberView.headerDateFormatter.string(from: currentPage)
    }
}

extension TeamMemberViewController {
    
    private func configureCalendar() {
        teamMemberView.calendarView.delegate = self
        teamMemberView.calendarView.dataSource = self
    }

    // MARK: - Selector
    
    @objc func tapToggleButton() {
        if teamMemberView.calendarView.scope == .month {
            teamMemberView.calendarView.setScope(.week, animated: true)
            teamMemberView.headerDateFormatter.dateFormat = "YYYY년 M월"
            teamMemberView.toggleButton.setImage(Icon.downIcon, for: .normal)
            teamMemberView.headerLabel.text = teamMemberView.headerDateFormatter.string(from: teamMemberView.calendarView.currentPage)
            
        } else {
            teamMemberView.calendarView.setScope(.month, animated: true)
            teamMemberView.headerDateFormatter.dateFormat = "YYYY년 M월"
            teamMemberView.toggleButton.setImage(Icon.upIcon, for: .normal)
            teamMemberView.headerLabel.text = teamMemberView.headerDateFormatter.string(from: teamMemberView.calendarView.currentPage)
        }
    }
}



extension TeamMemberViewController: UITableViewDelegate {}

extension TeamMemberViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(TeamMemberData.count)
        switch section {
        case 0:
            return TeamMemberData[0].reviewWriters?.count ?? 0
        case 1:
            return TeamMemberData[0].nonReviewWriters?.count ?? 0
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TeamMemberTableViewCell.identifier, for: indexPath) as? TeamMemberTableViewCell else { return UITableViewCell() }
        
        cell.configureCell(TeamMemberData[indexPath.row])
        return cell
    }
}
