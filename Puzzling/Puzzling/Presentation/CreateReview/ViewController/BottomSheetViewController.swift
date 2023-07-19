
//
//  BottomSheetViewController.swift
//  Puzzling
//
//  Created by 천성우 on 2023/07/11.
//

import UIKit

import Moya
import Then
import SnapKit

final class BottomSheetViewController: UIViewController {
    
    // MARK: - Properties
    var selectedOption: String?
    var onOptionSelected: ((Int) -> Void)?
    
    let optionFirstButton = CustomRadioButton(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
    let optionSecondButton = CustomRadioButton(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
    let optionThirdButton = CustomRadioButton(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
    
    private let optionFirstTitle = UILabel()
    private let optionSecondTitle = UILabel()
    private let optionThirdTitle = UILabel()
    
    private let optionFirstSubtitle = UILabel()
    private let optionSecondSubtitle = UILabel()
    private let optionThirdSubtitle = UILabel()
    
    let templatecaseProvider = MoyaProvider<CreateRetrospectService>(plugins: [NetworkLoggerPlugin()])
    private var templateList: [TemplateCaseModel] = []
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setAddTarget()
        fetchTemplateCase()
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
        
        optionFirstTitle.do {
            $0.textColor = .gray700
            $0.font = .fontGuide(.body1_bold_kor)
        }
        
        optionSecondTitle.do {
            $0.textColor = .gray700
            $0.font = .fontGuide(.body1_bold_kor)
        }
        
        optionThirdTitle.do {
            $0.textColor = .gray700
            $0.font = .fontGuide(.body1_bold_kor)
        }
        
        optionFirstSubtitle.do {
            $0.numberOfLines = 2
            $0.textColor = .gray600
            $0.font = .fontGuide(.detail1_regular_kor)
        }
        
        optionSecondSubtitle.do {
            $0.numberOfLines = 2
            $0.textColor = .gray600
            $0.font = .fontGuide(.detail1_regular_kor)
        }
        
        optionThirdSubtitle.do {
            $0.numberOfLines = 2
            $0.textColor = .gray600
            $0.font = .fontGuide(.detail1_regular_kor)
        }
    }
    
    // MARK: - Layout Helper

    private func setLayout() {
        
        view.addSubviews(optionFirstButton, optionFirstTitle, optionFirstSubtitle,
                         optionSecondButton, optionSecondTitle, optionSecondSubtitle,
                         optionThirdButton, optionThirdTitle, optionThirdSubtitle)
        
        optionFirstButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(57)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(16)
            $0.height.equalTo(16)
        }
        
        optionFirstTitle.snp.makeConstraints {
            $0.top.equalTo(optionFirstButton.snp.top)
            $0.leading.equalTo(optionFirstButton.snp.trailing).inset(-20)
        }
        
        optionFirstSubtitle.snp.makeConstraints {
            $0.top.equalTo(optionFirstTitle.snp.top)
            $0.leading.equalTo(optionFirstTitle.snp.trailing).inset(-30)
        }
        
        optionSecondButton.snp.makeConstraints {
            $0.top.equalTo(optionFirstButton.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(16)
            $0.height.equalTo(16)
        }
        
        optionSecondTitle.snp.makeConstraints {
            $0.top.equalTo(optionSecondButton.snp.top)
            $0.leading.equalTo(optionSecondButton.snp.trailing).inset(-20)
        }
        
        optionSecondSubtitle.snp.makeConstraints {
            $0.top.equalTo(optionSecondTitle.snp.top)
            $0.leading.equalTo(optionSecondTitle.snp.trailing).inset(-36)
        }
        
        optionThirdButton.snp.makeConstraints {
            $0.top.equalTo(optionSecondButton.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(16)
            $0.height.equalTo(16)
        }
        
        optionThirdTitle.snp.makeConstraints {
            $0.top.equalTo(optionThirdButton.snp.top)
            $0.leading.equalTo(optionThirdButton.snp.trailing).inset(-20)
        }
        
        optionThirdSubtitle.snp.makeConstraints {
            $0.top.equalTo(optionThirdTitle.snp.top)
            $0.leading.equalTo(optionThirdTitle.snp.trailing).inset(-22)
        }
        
        if selectedOption == "TIL" {
            optionFirstButton.btnSelected = true
            optionFirstButton.innerCircle.isHidden = false
        } else if selectedOption == "5F" {
            optionSecondButton.btnSelected = true
            optionSecondButton.innerCircle.isHidden = false
        } else if selectedOption == "AAR" {
            optionThirdButton.btnSelected = true
            optionThirdButton.innerCircle.isHidden = false
        }
    }
    
    // MARK: - Methods
    
    private func setAddTarget() {
        optionFirstButton.addTarget(self, action: #selector(optionFirstSelected), for: .touchUpInside)
        optionSecondButton.addTarget(self, action: #selector(optionSecondSelected), for: .touchUpInside)
        optionThirdButton.addTarget(self, action: #selector(optionThirdSelected), for: .touchUpInside)
    }
    
    func dismissBottomSheet() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - @objc Methods

    @objc func optionFirstSelected() {
        onOptionSelected?(optionFirstButton.tag)
        optionSecondButton.innerCircle.isHidden = true
        optionThirdButton.innerCircle.isHidden = true
        dismiss(animated: true, completion: nil)
    }
    
    @objc func optionSecondSelected() {
        onOptionSelected?(optionSecondButton.tag)
        optionFirstButton.innerCircle.isHidden = true
        optionThirdButton.innerCircle.isHidden = true
        dismiss(animated: true, completion: nil)
    }
    
    @objc func optionThirdSelected() {
        onOptionSelected?(optionThirdButton.tag)
        optionFirstButton.innerCircle.isHidden = true
        optionSecondButton.innerCircle.isHidden = true
        dismiss(animated: true, completion: nil)
    }
}

extension BottomSheetViewController {
    
    // MARK: - Network

    private func fetchTemplateCase() {
        templatecaseProvider.request(.reviewTemplate) { result in
            switch result {
            case .success(let result):
                do {
                    let status = result.statusCode
                    if status >= 200 && status < 300 {
                        let responseData = try result.map(GeneralResponse<[TemplateCaseResponce]>.self)
                        guard let data = responseData.data else {
                            return
                        }
                        self.templateList = data.map { $0.converToTemplateCase() }
                        print("❤️❤️❤️❤️❤️")
                        print(self.templateList)
                        print("❤️❤️❤️❤️❤️")
                        self.setUINetwork()
                    } else {
                        print("Request failed with status code: \(status)")
                    }
                } catch (let error) {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
        }
    }
    
    private func setUINetwork() {
        optionFirstTitle.text = self.templateList[0].reviewTemplateName
        optionFirstSubtitle.text = self.templateList[0].reviewTemplateMeaning
        optionFirstButton.tag = self.templateList[0].reviewTemplateId
        
        optionSecondTitle.text = self.templateList[1].reviewTemplateName
        optionSecondSubtitle.text = self.templateList[1].reviewTemplateMeaning
        optionSecondButton.tag = self.templateList[1].reviewTemplateId
        
        optionThirdTitle.text = self.templateList[2].reviewTemplateName
        optionThirdSubtitle.text = self.templateList[2].reviewTemplateMeaning
        optionThirdButton.tag = self.templateList[2].reviewTemplateId
    }
}
