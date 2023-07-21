//
//  ViewController.swift
//  Puzzling-iOS
//
//  Created by KYUBO A. SHIM on 2023/07/10.
//

import UIKit

import Moya
import SnapKit
import Then

final class HomeViewController: UIViewController {
    
    // MARK: - UI Components
    
    private var alarmView: UIView?
    private var titleBarView = HomeTitleBarView()
    private let segmentedView = HomeSegmentedView()
    private let indivisualDashboardViewController = IndivisualDashboardViewController()
    private let teamDashboardViewController = TeamDashboardViewController()
    private lazy var dashboardViewControllers: [UIViewController] = [indivisualDashboardViewController, teamDashboardViewController]
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    private var currentPage: UIViewController!
    
    // MARK: - Properties
    
    // TODO: 전역 변수로 받아와야함
    private var currentProjectId: Int = UserDefaults.standard.integer(forKey: "projectId")
    private var memberId: Int = UserDefaults.standard.integer(forKey: "memberId")
    
    private let authProvider = MoyaProvider<AuthService>(plugins:[NetworkLoggerPlugin()])
    private var tokenModel: TokenModel = TokenModel(accessToken: "")
    private let dashboardNetworkProvider = MoyaProvider<ProjectServiceKBS>(plugins: [NetworkLoggerPlugin(verbose: true)])
    private var tabBarHeight: CGFloat {
        guard let height = self.tabBarController?.tabBar.frame.size.height else { return 0.0 }
        return height
    }
    private var currentProjectTitle: String = ""
    private var currentProjectRetrospectCycle: String = ""
    private var ongoingProjectArray: [OngoingProjectData] = []
    
    // MARK: - View Life Cycle
            
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setUI()
        setLayout()
        setPage()
        setData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        setBackButton()
    }
    
    deinit {
        print(className)
    }
}

extension HomeViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        view.backgroundColor = .white000
        
        pageViewController.do {
            $0.didMove(toParent: self)
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        self.addChild(pageViewController)
        view.addSubviews(titleBarView, segmentedView, pageViewController.view)
        
        titleBarView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(48)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
        }
        
        segmentedView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(50)
            $0.top.equalTo(titleBarView.snp.bottom)
        }
        
        pageViewController.view.snp.makeConstraints {
            $0.top.equalTo(segmentedView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(tabBarHeight)
        }
    }
    
    // MARK: - Methods
    
    private func setData() {
        setHomeData()
        setIndivisualDashboardData()
        setTeamDashboardData()
    }
    
    private func setDelegate() {
        titleBarView.delegate = self
        segmentedView.delegate = self
        indivisualDashboardViewController.mainView.puzzleCollectionView.delegateForIndivisual = self
        teamDashboardViewController.mainView.puzzleCollectionView.delegateForTeam = self
    }
    
    private func setPage() {
        if let firstViewController = dashboardViewControllers.first {
            pageViewController.setViewControllers([firstViewController], direction: .forward, animated: false)
            currentPage = firstViewController
        }
    }
    
    private func setHomeData() {
        // MARK: - 모든 프로젝트 들고오기
        dashboardNetworkProvider.request(.fetchOngoingProjectList(memberId: self.memberId)) { [weak self] response in
            switch response {
            case .success(let result):
                let status = result.statusCode
                switch status {
                case 200..<299:
                    guard let data = try? result.map(GeneralResponse<[OngoingProjectData]>.self).data else {
                        return
                    }
                    
                    guard let currentProject = data.filter({
                        $0.projectId == self?.currentProjectId
                    }).first else { return }

                    self?.currentProjectId = currentProject.projectId
                    self?.currentProjectTitle = currentProject.projectName
                    self?.ongoingProjectArray = data
                    self?.titleBarView.setTitleOfProject(title: currentProject.projectName)
                    self?.teamDashboardViewController.teamRankView.passProjectName(projectName: currentProject.projectName)
                    // 23-07-21 AM 10:21 회고 작성뷰 Title 넘미기위한 코드 추가 
                    self?.indivisualDashboardViewController.passUserInformation(memberId: self?.memberId ?? 0, projectId: currentProject.projectId, projectTitle: currentProject.projectName)
                    
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
    
    private func setIndivisualDashboardData() {
        // MARK: - 개인 퍼즐 정보 가져오기
        dashboardNetworkProvider.request(.fetchIndivisualPuzzle(memberId: self.memberId, projectId: self.currentProjectId, todayString: Date().dateToServerString)) { [weak self] response in
            switch response {
            case .success(let result):
                let status = result.statusCode
                switch status {
                case 200..<299:
                    guard let data = try? result.map(GeneralResponse<IndivisualData>.self).data else {
                        return
                    }
                    let userName: String = data.myPuzzle.nickname
                    let puzzleCount: Int = data.myPuzzle.puzzleCount
                    let totalPuzzleBoardCount = data.puzzleBoardCount
                    let puzzles = data.userPuzzleBoard
                    let hasReviewed = data.hasTodayReview
                    self?.indivisualDashboardViewController.mainView.passPuzzleData(userName: userName, piecesCount: puzzleCount, totalPuzzleBoardCount: totalPuzzleBoardCount, dashboardData: puzzles)
                    self?.indivisualDashboardViewController.mainView.reloadPuzzleView(withTodayReviewedCheck: hasReviewed)
                    self?.indivisualDashboardViewController.passBoardCount(count: totalPuzzleBoardCount)
                    
                    if data.hasTodayReview == true {
                        self?.indivisualDashboardViewController.homeMainButton.enableButton(toType: .done)
                        return
                    }

                    if data.isReviewDay == false {
                        self?.indivisualDashboardViewController.homeMainButton.enableButton(toType: .notToday)
                        return
                    }
                    self?.indivisualDashboardViewController.homeMainButton.enableButton(toType: .today)
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
        
        // MARK: - Action Plan 가져오기
        dashboardNetworkProvider.request(.fetchActionPlans(memberId: self.memberId, projectId: self.currentProjectId)) { [weak self] response in
            switch response {
            case .success(let result):
                let status = result.statusCode
                switch status {
                case 200..<299:
                    guard let data = try? result.map(GeneralResponse<[ActionPlan]>.self).data else {
                        return
                    }
                    self?.indivisualDashboardViewController.actionPlanView.passActionPlanView(data: data)
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
        
        // MARK: - 회고 주기 가져오기
        dashboardNetworkProvider.request(.fetchRetrospectCycle(projectId: self.currentProjectId)) { [weak self] response in
            switch response {
            case .success(let result):
                let status = result.statusCode
                switch status {
                case 200..<299:
                    guard let data = try? result.map(GeneralResponse<ProjectCycle>.self).data else { return }
                    
                    self?.currentProjectRetrospectCycle = data.projectReviewCycle
                    
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
    
    private func setTeamDashboardData() {
        // MARK: - 팀 퍼즐 가져오기
        dashboardNetworkProvider.request(.fetchTeamPuzzle(projectId: self.currentProjectId, todayString: Date().dateToServerString)) { [weak self] response in
            switch response {
            case .success(let result):
                let status = result.statusCode
                switch status {
                case 200..<299:
                    guard let data = try? result.map(GeneralResponse<TeamDashboardData>.self).data else {
                        return
                    }

                    let userName: String = data.myPuzzle.nickname
                    let puzzleCount: Int = data.myPuzzle.puzzleCount
                    let totalPuzzleBoardCount = data.teamPuzzleBoardCount
                    let puzzles = data.teamPuzzleBoard
                    let hasTodayReviewed = data.hasTodayReview
                    
                    self?.teamDashboardViewController.mainView.passPuzzleData(userName: userName, piecesCount: puzzleCount, totalPuzzleBoardCount: totalPuzzleBoardCount, dashboardData: puzzles)
                    self?.teamDashboardViewController.mainView.reloadPuzzleView()
                    self?.teamDashboardViewController.passBoardCount(count: totalPuzzleBoardCount)
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
        
        // MARK: - 팀 랭크 가져오기
        dashboardNetworkProvider.request(.fetchTeamRankTable(projectId: self.currentProjectId)) { [weak self] response in
            switch response {
            case .success(let result):
                let status = result.statusCode
                switch status {
                case 200..<299:
                    guard let data = try? result.map(GeneralResponse<[TeamProjectRank]>.self).data else {
                        return
                    }
                    let orderedRankData = data.sorted {
                        ($1.memberPuzzleCount, $0.memberNickname) < ($0.memberPuzzleCount, $1.memberNickname)
                    }
                    
                    self?.teamDashboardViewController.passTeamArray(data: data)
                    self?.teamDashboardViewController.teamRankView.passTopThreeData(data: orderedRankData)
                    self?.teamDashboardViewController.teamRankView.passOrderedRankData(data: orderedRankData)
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
    
    func getNewToken() {
        guard let access = KeyChain.read(key: "accessToken") else { return }
        guard let refresh = KeyChain.read(key: "refreshToken") else { return }
        authProvider.request(.authToken(Authorization: access, Refresh: refresh)) { result in
            switch result {
            case .success(let result):
                let status = result.statusCode
                if status >= 200 && status < 300 {
                    do {
                        guard let data = try result.map(GeneralResponse<TokenResponse>.self).data else { return }
                        self.tokenModel = data.convertToTokenModel()
                        KeyChain.create(key: "accessToken", token: self.tokenModel.accessToken)
                        APIConstants.accessToken = self.tokenModel.accessToken
                    } catch(let error) {
                        print(error.localizedDescription)
                    }
                }
                else if status >= 400 {
                    print("⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setBackButton() {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backButton.tintColor = .gray500
        self.navigationItem.backBarButtonItem = backButton
    }
}

extension HomeViewController: HomeBottomSheetDelegate {
    func popAlarmAction() {
        print(self.currentProjectTitle)
        let modifiedCycleString = self.currentProjectRetrospectCycle.replacingOccurrences(of: ",", with: ", ")
        alarmView = PopUpDayView(frame: .zero, projectTitle: self.currentProjectTitle, daysString: modifiedCycleString)
        self.titleBarView.alarmButton.isEnabled = false
        view.addSubview(alarmView ?? UIView())
        
        alarmView?.snp.makeConstraints {
            $0.top.equalTo(titleBarView.snp.bottom).offset(-8)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalToSuperview().dividedBy(2.2)
            $0.height.equalToSuperview().dividedBy(6.9)
        }
        
        UIView.animate(withDuration: 1.5, delay: 1.2, options: .curveEaseOut) { [weak self] in
            self?.alarmView?.alpha = 0
        } completion: { [weak self] _ in
            self?.alarmView?.removeFromSuperview()
            self?.alarmView = nil
            self?.titleBarView.alarmButton.isEnabled = true
        }
    }
    
    func openBottomSheet() {
        let bottomSheetViewController = HomeBottomSheetViewController()
        bottomSheetViewController.modalPresentationStyle = .pageSheet
        bottomSheetViewController.passOngoingProjectsData(projects: ongoingProjectArray, currentId: self.currentProjectId, currentProjectTitle: self.currentProjectTitle)
        
        if let sheet = bottomSheetViewController.sheetPresentationController {
            sheet.detents = [.custom { [weak self] _ in
                let detentHeight: Int
                guard let count = self?.ongoingProjectArray.count else { return 0 }
                if count < 5 {
                    detentHeight = count * 60 + 200
                    return CGFloat(detentHeight)
                } else {
                    detentHeight = 470
                    return CGFloat(detentHeight)
                }
            }]
            sheet.preferredCornerRadius = 16
            sheet.prefersGrabberVisible = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }
        bottomSheetViewController.delegate = self
        self.navigationController?.present(bottomSheetViewController, animated: true)
    }
}

extension HomeViewController: HomeBottomSheetPassNewProjectDelegate {
    func changeProjectId(to newId: Int) {
        self.currentProjectId = newId
        UserDefaults.standard.setValue(newId, forKey: "projectId")
        // 새로운 통신
        self.setData()
    }
}

extension HomeViewController: HomeSegmentDelegate {
    func movePage(to index: Int) {
        switch index {
        case 0:
            switchPage(difference: 1)
        case 1:
            switchPage(difference: -1)
        default:
            break
        }
    }
    
    private func switchPage(difference: Int) {
        guard let page = dashboardViewControllers.firstIndex(of: currentPage) else { return }
        switch difference {
        case 1:
            pageViewController.setViewControllers([dashboardViewControllers[page + difference]], direction: .forward, animated: true)
        case -1:
            pageViewController.setViewControllers([dashboardViewControllers[page + difference]], direction: .reverse, animated: true)
        default:
            break
        }
        currentPage = dashboardViewControllers[page + difference]
    }
}

extension HomeViewController: MainPuzzleCollectionPassEventForIndivisuals, MaMainPuzzleCollectionPassEventForTeam {
    func passTouchEventIndivisual(withDate: String) {
        let indivisualMemberViewController = ReviewDetailViewController()
        /// TODO: 여기에도 passData 해야함
        self.navigationController?.pushViewController(indivisualMemberViewController, animated: true)
    }
    
    func passTouchEventTeam(withDate: String) {
        let teamMemberViewController = TeamMemberViewController()
        teamMemberViewController.passData(date: withDate, title: self.currentProjectTitle)
        self.navigationController?.pushViewController(teamMemberViewController, animated: true)
    }
}
