//
//  PuzzleBoardViewController.swift
//  Puzzling
//
//  Created by KYUBO A. SHIM on 2023/07/20.
//

import UIKit

import SnapKit
import Then

final class PuzzleBoardViewController: UIViewController, UIGestureRecognizerDelegate {

    private var puzzleBoardCount: Int = 0
    
    private let emptyLabel = UILabel()
    private var puzzleBoardArray: [PuzzleBoardData] = []
    private var navigationTitle: String = ""
    private lazy var puzzleCollectionView = UICollectionView(frame: .zero, collectionViewLayout: setFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setUI()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        navigationController?.isNavigationBarHidden = false
        navigationItem.titleView = self.attributeTitleView()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: Image.chevronBackIcon,
            style: .plain,
            target: self,
            action: #selector(popAction)
        )
        
        navigationItem.leftBarButtonItem?.tintColor = .gray500
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        tabBarController?.tabBar.isHidden = false
        navigationController?.isNavigationBarHidden = true
    }
    
    deinit {
        print(className)
    }
}

extension PuzzleBoardViewController {
    
    private func setDelegate() {
        puzzleCollectionView.delegate = self
        puzzleCollectionView.dataSource = self
    }
    
    private func setUI() {
        view.backgroundColor = .white000
        
        puzzleCollectionView.do {
            $0.registerCell(PuzzleBoardCollectionViewCell.self)
            $0.backgroundColor = .clear
        }
        
        emptyLabel.do {
            $0.text = "완성한 퍼즐판이 없어요!"
            $0.font = .fontGuide(.body1_bold_kor)
            $0.textColor = .gray400
        }
    }
    
    private func setLayout() {
        view.addSubviews(puzzleCollectionView, emptyLabel)
        
        puzzleCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
        emptyLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

extension PuzzleBoardViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return puzzleBoardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(type: PuzzleBoardCollectionViewCell.self, indexPath: indexPath)
        cell.passPuzzleInformation(dateString: puzzleBoardArray[indexPath.item].date, puzzleImageName: puzzleBoardArray[indexPath.item].imageName)
        return cell
    }
}

extension PuzzleBoardViewController {
    private func setFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height / 3.6)
        layout.scrollDirection = .vertical
        return layout
    }
    
    private func attributeTitleView() -> UIView {
        let label: UILabel = UILabel()
        let title: NSMutableAttributedString =
        NSMutableAttributedString(string: self.navigationTitle, attributes: [
            .foregroundColor: UIColor.black000,
            .font: UIFont.fontGuide(.heading4_kor)
        ])
        
        let naviTitle: NSMutableAttributedString
        = title
        label.attributedText = naviTitle
        
        return label
    }
    
    @objc
    private func popAction() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension PuzzleBoardViewController {
    func passNavigationTitle(boardType: DashboardType) {
        self.navigationTitle = boardType.navigationTitle
    }
    
    func passPuzzleBoardCount(count: Int) {
        let defaultArray: [PuzzleBoardData] = [PuzzleBoardData(date: "2023.06.18. ~ 2023.07.02.", imageName: "puzzleBoard1"), PuzzleBoardData(date: "2023.07.03. ~ 2023.07.18.", imageName: "puzzleBoard2"), PuzzleBoardData(date: "2023.07.19. ~ 2023.08.02.", imageName: "puzzleBoard3")]
        var array: [PuzzleBoardData] = []
        for item in 0..<count {
            array.append(defaultArray[item])
        }
        self.puzzleBoardArray = array
        self.puzzleBoardCount = array.count
        
        if array.count > 0 {
            self.emptyLabel.alpha = 0
            self.emptyLabel.removeFromSuperview()
        }
    }
}
