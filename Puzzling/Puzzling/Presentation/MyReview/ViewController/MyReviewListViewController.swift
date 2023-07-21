//
//  MyReviewListViewController.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/14.
//

import UIKit

import SnapKit
import Then
import Moya

protocol StringTransferDelegate: AnyObject {
    func passString(_ value: String)
}

final class MyReviewListViewController: UIViewController {
    
    weak var delegate: StringTransferDelegate?
    
    private var currentProjectTitle: String = "Project1"
    private var currentProjectId: Int = 0
    
    private var currentReviewDate: String = ""
    
    private let myReviewListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let myProjectProvider = MoyaProvider<MyProjectService>(plugins:[NetworkLoggerPlugin()])
    
    private var myReviewListData: [ReviewListResponse] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setDelegate()
        setRegister()
        fetchReviewList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }
    
    deinit {
        print(className)
    }
}

extension MyReviewListViewController {
    
    private func setUI() {
        view.backgroundColor = .white000
        
        myReviewListCollectionView.do {
            $0.contentInsetAdjustmentBehavior = .never
            $0.collectionViewLayout = UICollectionViewFlowLayout()
            $0.showsVerticalScrollIndicator = false
        }
    }
    
    private func setLayout() {
        view.addSubviews(myReviewListCollectionView)
        
        myReviewListCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setDelegate() {
        myReviewListCollectionView.delegate = self
        myReviewListCollectionView.dataSource = self
    }
    
    private func setRegister() {
        myReviewListCollectionView.registerCell(MyReviewListCollectionViewCell.self)
        myReviewListCollectionView.registerHeader(ProjectNameCollecionReusableView.self)
    }
    
    private func reloadHeaderView(text: String) {
        guard let headerView = myReviewListCollectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0)) as? ProjectNameCollecionReusableView else { return }
        headerView.setDataBind(projectName: self.currentProjectTitle)
    }
}


extension MyReviewListViewController: UIGestureRecognizerDelegate {
    
    private func setNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: Image.chevronBackIcon,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )

        navigationItem.leftBarButtonItem?.tintColor = .gray500
        
        let title = currentProjectTitle
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
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
}


extension MyReviewListViewController {
    @objc
    private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension MyReviewListViewController: projectNameProtocol {
    func nameData(id: Int, text: String) {
        self.currentProjectTitle = text
        self.currentProjectId = id
        self.setNavigationBar()
        self.fetchReviewList()
        reloadHeaderView(text: text)
    }
}

extension MyReviewListViewController: buttonTappedProtocol {
    func passButtonEvent(projectName: String) {
        self.currentProjectTitle = projectName
        
        let vc = MyPageBottomSheetViewController()
        vc.delegate = self
        vc.setProjectName(projectName: projectName)
        vc.modalPresentationStyle = .pageSheet
        let smallId = UISheetPresentationController.Detent.Identifier("small")
        let smallDetent = UISheetPresentationController.Detent.custom(identifier: smallId) { context in
            return 300
        }
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [smallDetent, .medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        present(vc, animated: true, completion: nil)
    }
}

extension MyReviewListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = ReviewDetailViewController()
        let cell = collectionView.cellForItem(at: indexPath) as? MyReviewListCollectionViewCell
        if let selectedCell = cell {
            currentReviewDate = cell?.getSelectedData() ?? "2023-07-17"
            print(currentReviewDate, "zzzzzz")
        }
//        vc.delegate = self
        vc.passString(currentReviewDate)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MyReviewListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        myReviewListData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myReviewListCollectionView.dequeueCell(type: MyReviewListCollectionViewCell.self, indexPath: indexPath)
        cell.setDataBind(myReviewListData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = myReviewListCollectionView.dequeueReusableCell(kind: UICollectionView.elementKindSectionHeader, type: ProjectNameCollecionReusableView.self, indexPath: indexPath)
        view.delegate = self
        view.setDataBind(projectName: currentProjectTitle)
        return view
    }
}

extension MyReviewListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width-32, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 12, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width-32, height: 82)
    }
}

extension MyReviewListViewController {
    
    // MARK: - Network
    
    private func fetchReviewList() {
        guard let memberId = UserDefaults.standard.string(forKey: "memberId") else { return }
        print(memberId)
        myProjectProvider.request(.myReviewList(memberId: "1", projectId: "\(self.currentProjectId)")) { result in
            switch result {
            case .success(let result):
                let status = result.statusCode
                print(status)
                if status >= 200 && status < 300 {
                    do {
                        guard let data = try result.map(GeneralResponse<[ReviewListResponse]>.self).data else { return }
                        self.myReviewListData = data
                        self.myReviewListCollectionView.reloadData()
                        
                        print("💙💙💙💙💙💙💙💙💙💙💙💙💙💙💙💙💙💙💙💙💙💙")
                        
                        
                    } catch(let error) {
                        print(error.localizedDescription)
                    }
                } else if status == 404 {
                    print("💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension MyReviewListViewController {
    func passData(id: Int, title: String) {
        self.currentProjectTitle = title
        self.currentProjectId = id
    }
}
