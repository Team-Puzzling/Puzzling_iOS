
//
//  BottomSheetViewController.swift
//  Puzzling
//
//  Created by 천성우 on 2023/07/11.
//

import UIKit

import Then

final class BottomSheetViewController: UIViewController {
    
    // MARK: - Properties
    
    var selectedOption: String?
    
    var onOptionSelected: ((String) -> Void)?
    
    let optionTILButton = CustomRadioButton(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
    let optionFiveFButton = CustomRadioButton(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
    let optionAARButton = CustomRadioButton(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
    
    private let optionTILTitle = UILabel()
    private let optionFiveFTitle = UILabel()
    private let optionAARTitle = UILabel()
    
    private let optionTILSubtitle = UILabel()
    private let optionFiveFSubtitle = UILabel()
    private let optionAARSubtitle = UILabel()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setAddTarget()
    }
    
    // MARK: - deinit

    deinit {
        print("BottomSheetViewController deinit")
    }
}
 
extension BottomSheetViewController {

    // MARK: - UI Components Property

    private func setUI() {

        view.backgroundColor = .white000

        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.preferredCornerRadius = 20
            sheetPresentationController.prefersGrabberVisible = true
            sheetPresentationController.detents = [.custom {context in
                return 274
            }]
        }
        
        optionTILTitle.do {
            $0.text = "TIL"
            $0.textColor = .gray700
            $0.font = .fontGuide(.body1_bold_kor)
        }
        
        optionFiveFTitle.do {
            $0.text = "5F"
            $0.textColor = .gray700
            $0.font = .fontGuide(.body1_bold_kor)
        }
        
        optionAARTitle.do {
            $0.text = "AAR"
            $0.textColor = .gray700
            $0.font = .fontGuide(.body1_bold_kor)
        }
        
        optionTILSubtitle.do {
            $0.text = "학습과 자기 반성을 통해 향후 더 나은 결정을 내릴 \n수 있게 해 주는 회고 방식이에요!"
            $0.numberOfLines = 2
            $0.textColor = .gray600
            $0.font = .fontGuide(.detail1_regular_kor)
        }
        
        optionFiveFSubtitle.do {
            $0.text = "다양한 측면을 고려하여 개인과 프로젝트 전체적인 \n관점을 보여주는 회고 방식이에요!"
            $0.numberOfLines = 2
            $0.textColor = .gray600
            $0.font = .fontGuide(.detail1_regular_kor)
        }
        
        optionAARSubtitle.do {
            $0.text = "목표 달성에 대한 책임감과 함께, 개선에 중점을 두\n는 회고 방식이에요!"
            $0.numberOfLines = 2
            $0.textColor = .gray600
            $0.font = .fontGuide(.detail1_regular_kor)
        }
    }
    
    // MARK: - Layout Helper

    private func setLayout() {
        
        view.addSubviews(optionTILButton, optionTILTitle, optionTILSubtitle,
                         optionFiveFButton, optionFiveFTitle, optionFiveFSubtitle,
                         optionAARButton, optionAARTitle, optionAARSubtitle)
        
        optionTILButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(57)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(16)
            $0.height.equalTo(16)
        }
        
        optionTILTitle.snp.makeConstraints {
            $0.top.equalTo(optionTILButton.snp.top)
            $0.leading.equalTo(optionTILButton.snp.trailing).inset(-20)
        }
        
        optionTILSubtitle.snp.makeConstraints {
            $0.top.equalTo(optionTILTitle.snp.top)
            $0.leading.equalTo(optionTILTitle.snp.trailing).inset(-30)
        }
        
        optionFiveFButton.snp.makeConstraints {
            $0.top.equalTo(optionTILButton.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(16)
            $0.height.equalTo(16)
        }
        
        optionFiveFTitle.snp.makeConstraints {
            $0.top.equalTo(optionFiveFButton.snp.top)
            $0.leading.equalTo(optionFiveFButton.snp.trailing).inset(-20)
        }
        
        optionFiveFSubtitle.snp.makeConstraints {
            $0.top.equalTo(optionFiveFTitle.snp.top)
            $0.leading.equalTo(optionFiveFTitle.snp.trailing).inset(-36)
        }
        
        optionAARButton.snp.makeConstraints {
            $0.top.equalTo(optionFiveFButton.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(16)
            $0.height.equalTo(16)
        }
        
        optionAARTitle.snp.makeConstraints {
            $0.top.equalTo(optionAARButton.snp.top)
            $0.leading.equalTo(optionAARButton.snp.trailing).inset(-20)
        }
        
        optionAARSubtitle.snp.makeConstraints {
            $0.top.equalTo(optionAARTitle.snp.top)
            $0.leading.equalTo(optionAARTitle.snp.trailing).inset(-22)
        }
        
        if selectedOption == "TIL" {
            optionTILButton.btnSelected = true
            optionTILButton.innerCircle.isHidden = false
        } else if selectedOption == "5F" {
            optionFiveFButton.btnSelected = true
            optionFiveFButton.innerCircle.isHidden = false
        } else if selectedOption == "AAR" {
            optionAARButton.btnSelected = true
            optionAARButton.innerCircle.isHidden = false
        }
    }
    
    // MARK: - Methods
    
    private func setAddTarget() {
        optionTILButton.addTarget(self, action: #selector(optionTILSelected), for: .touchUpInside)
        optionFiveFButton.addTarget(self, action: #selector(optionFiveFSelected), for: .touchUpInside)
        optionAARButton.addTarget(self, action: #selector(optionAARSelected), for: .touchUpInside)
    }
    
    func dismissBottomSheet() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - @objc Methods

    @objc func optionTILSelected() {
        onOptionSelected?("TIL")
        optionFiveFButton.innerCircle.isHidden = true
        optionAARButton.innerCircle.isHidden = true
        dismiss(animated: true, completion: nil)
    }
    
    @objc func optionFiveFSelected() {
        onOptionSelected?("5F")
        optionTILButton.innerCircle.isHidden = true
        optionAARButton.innerCircle.isHidden = true
        dismiss(animated: true, completion: nil)
    }
    
    @objc func optionAARSelected() {
        onOptionSelected?("AAR")
        optionTILButton.innerCircle.isHidden = true
        optionFiveFButton.innerCircle.isHidden = true
        dismiss(animated: true, completion: nil)
    }
}
