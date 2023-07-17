//
//  TeamMemberViewController.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/17.
//

import UIKit

import FSCalendar
import SnapKit
import Then

final class TeamMemberViewController: UIViewController {
    
    private var index: Int = 0
    
    private var selectedDate: String = ""
    
    private var specificData = TeamMemberDataModel(reviewDay: "", reviewDate: "", reviewWriters: nil, nonReviewWriters: nil)
    
    
    private func findData(date: String) -> TeamMemberDataModel? {
        var data = TeamMemberDataModel(reviewDay: "", reviewDate: selectedDate, reviewWriters: nil, nonReviewWriters: nil)
        teamMemberData.forEach {
            if($0.reviewDate == date){
                data = $0
            }
        }
        return data
    }
    
    private let teamMemberCalenderView = TeamMemberCalendarView()
    private let teamMemberTableView = UITableView(frame: .zero, style: .grouped)
    
    private let teamMemberData = TeamMemberDataModel.dummy()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setUI()
        setLayout()
        setRegister()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setCalendarViewLayout()
        setNotificationCenter()
    }
    
    deinit {
        print(className)
    }
}

extension TeamMemberViewController {
    
    private func setDelegate() {
        teamMemberTableView.delegate = self
        teamMemberTableView.dataSource = self
    }
    
    private func setUI() {
        view.backgroundColor = .white000
        
        teamMemberTableView.do {
            $0.separatorStyle = .none
            $0.backgroundColor = .clear
            $0.sectionHeaderTopPadding = 0
            $0.sectionFooterHeight = 0
        }
    }
    
    private func setLayout() {
        view.addSubviews(teamMemberCalenderView, teamMemberTableView)
        
        teamMemberCalenderView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(32.0)
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.height.equalTo(teamMemberCalenderView.getCalendarViewHeight())
        }
        
        teamMemberTableView.snp.makeConstraints {
            $0.top.equalTo(teamMemberCalenderView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setRegister() {
        teamMemberTableView.registerCell(TeamMemberTableViewCell.self)
        teamMemberTableView.registerReusableView(TeamMemberCustomHeaderView.self)
    }
    
    private func setNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: Image.leftIcon,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        let title = "프로젝트 1"
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.black000,
            NSAttributedString.Key.font: UIFont.fontGuide(.heading4_kor)
        ]
        
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.attributedText = NSAttributedString(string: title, attributes: attributes)
        } else {
            let titleLabel = UILabel()
            titleLabel.attributedText = NSAttributedString(string: title, attributes: attributes)
            navigationItem.titleView = titleLabel
        }
    }
    
    private func setCalendarViewLayout() {
        teamMemberCalenderView.snp.remakeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.height.equalTo(teamMemberCalenderView.getCalendarViewHeight())
        }
    }
    
    private func setNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(getDateNotification(_:)), name: Notification.Name("dateNotification"), object: nil)
    }
}

extension TeamMemberViewController {
    
    @objc
    private func backButtonTapped() {
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
    
    @objc
    private func tapToggleButton() {
        teamMemberCalenderView.setDataBind()
    }
    
    @objc
    private func getDateNotification(_ notification: Notification) {
        let dateNotification = notification.userInfo?["userInfo"]
        selectedDate = dateNotification as! String
        specificData = findData(date: selectedDate) ?? TeamMemberDataModel(reviewDay: "", reviewDate: "", reviewWriters: nil, nonReviewWriters: nil)
        teamMemberTableView.reloadData()
    }
}

extension TeamMemberViewController: UITableViewDelegate {}

extension TeamMemberViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return specificData.reviewWriters?.count ?? 0
        case 1:
            return specificData.nonReviewWriters?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let cell = tableView.dequeueCell(type: TeamMemberTableViewCell.self, indexPath: indexPath)
        let data = specificData
        var nickname: String = ""
        var part: String = ""
        switch section {
        case 0:
            nickname = data.reviewWriters?[indexPath.row].memberNickname ?? ""
            part = data.reviewWriters?[indexPath.row].memberRole ?? ""
        case 1:
            nickname = data.nonReviewWriters?[indexPath.row].memberNickname ?? ""
            part = data.nonReviewWriters?[indexPath.row].memberRole ?? ""
        default:
            break
        }
        cell.setDataBind(nickname: nickname, part: part)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableView(type: TeamMemberCustomHeaderView.self)
        view.setDataBind(section: section)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0: if(specificData.reviewWriters == nil) { return 0 }
            else { return 48 }
        case 1: if(specificData.nonReviewWriters == nil) { return 0 }
            else { return 48 }
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0: if(specificData.reviewWriters == nil) { return 0 }
            else { return 16 }
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 49
    }
}
