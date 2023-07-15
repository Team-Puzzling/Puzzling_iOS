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
    let startDayView = StartDayView()
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
    
    private var selectedCycleIndex: [Int] = []
    private var activateTextFieldType: InputContentType?
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        setDelegate()
        setRegister()
        setTapScreen()
        print(nameView.frame.maxY)
        print(descriptionView.frame.maxY)
//        addKeyboardObserver()
        setNotificationCenter()
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
            $0.isScrollEnabled = false
            $0.allowsMultipleSelection = true
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
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(69)
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
    
    private func setNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(getTextFieldInfo(_:)), name: Notification.Name("textFieldInfoNotification"), object: nil)
    }
    
    private func cycleNotification(list: [Int]) {
        let userInfo = list
        NotificationCenter.default.post(
            name: Notification.Name("cycleNotification"),
            object: nil,
            userInfo: ["userInfo": userInfo]
        )
    }
    
    private func setTapScreen() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapScreen))
        tapGestureRecognizer.cancelsTouchesInView = false
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func addKeyboardObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func didTapScreen(_ gesture: UITapGestureRecognizer) {
        let touchLocation = gesture.location(in: self)
        if !cycleCollectionView.frame.contains(touchLocation) {
            self.endEditing(true)
        }
    }
    
    @objc
    private func keyboardWillShow(_ notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        let keyboardHeight = keyboardFrame.height
        var containerViewMaxY = nicknameView.frame.maxY
        if let activateTextField = activateTextFieldType {
            switch activateTextField {
            case .name:
                return
            case .description:
                containerViewMaxY = descriptionView.frame.maxY
            case .role:
                containerViewMaxY = roleView.frame.maxY
            case .nickname:
                containerViewMaxY = nicknameView.frame.maxY
            }
        }
        let screenHeight = UIScreen.main.bounds.height
        let distance = keyboardHeight - (screenHeight - containerViewMaxY)
        
        UIView.animate(withDuration: 0.25) {
            self.frame.origin.y = distance > 0 ? -distance : 0
        }
    }
    
//    @objc func keyboardWillShow(_ sender: Notification) {
//        guard let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
//              let currentTextField = UIResponder.currentFirstResponder as? UITextField else { return }
//        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
//        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
//        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
//
//        if textFieldBottomY > keyboardTopY {
//            let keyboardOverlap = textFieldBottomY - keyboardTopY
//            view.frame.origin.y = -keyboardOverlap
//        }
//    }

    
    @objc
    private func keyboardWillHide() {
        UIView.animate(withDuration: 0.25) {
            self.frame.origin.y = 0
        }
    }
    
    @objc
    private func getTextFieldInfo(_ notification: Notification) {
        if let textInfo = notification.userInfo?["userInfo"] as? InputContentType {
            activateTextFieldType = textInfo
        }
    }
}

extension CreateProjectView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width - 7 - 32
        let width = Int(screenWidth / 7)
        let height = width
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.isSelected = true
        selectedCycleIndex.append(indexPath.row)
        cycleNotification(list: selectedCycleIndex)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.isSelected = false
        if let index = selectedCycleIndex.firstIndex(of: indexPath.row) {
            selectedCycleIndex.remove(at: index)
        }
        cycleNotification(list: selectedCycleIndex)
    }
}
