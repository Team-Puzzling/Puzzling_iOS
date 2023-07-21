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
    
    private let optionFirstView = UIView()
    private let optionSecondView = UIView()
    private let optionThirdView = UIView()
    
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
        
        view.addSubviews(optionFirstView, optionSecondView, optionThirdView)
        
        optionFirstView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(40)

        }

        optionSecondView.snp.makeConstraints {
            $0.top.equalTo(optionFirstView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(40)

        }

        optionThirdView.snp.makeConstraints {
            $0.top.equalTo(optionSecondView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(40)
        }
        
        optionFirstView.addSubviews(optionFirstButton, optionFirstTitle, optionFirstSubtitle)
        optionSecondView.addSubviews(optionSecondButton, optionSecondTitle, optionSecondSubtitle)
        optionThirdView.addSubviews(optionThirdButton, optionThirdTitle, optionThirdSubtitle)
        
        optionFirstButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(16)
        }

        optionFirstTitle.snp.makeConstraints {
            $0.top.equalTo(optionFirstButton.snp.top)
            $0.leading.equalTo(optionFirstButton.snp.trailing).offset(20)
        }

        optionFirstSubtitle.snp.makeConstraints {
            $0.top.equalTo(optionFirstTitle.snp.top)
            $0.leading.equalTo(optionFirstTitle.snp.trailing).offset(27)
        }

        optionSecondButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(16)
        }

        optionSecondTitle.snp.makeConstraints {
            $0.top.equalTo(optionSecondButton.snp.top)
            $0.leading.equalTo(optionSecondButton.snp.trailing).offset(20)
        }

        optionSecondSubtitle.snp.makeConstraints {
            $0.top.equalTo(optionSecondTitle.snp.top)
            $0.leading.equalTo(optionSecondTitle.snp.trailing).offset(33)
        }

        optionThirdButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(16)
        }

        optionThirdTitle.snp.makeConstraints {
            $0.top.equalTo(optionThirdButton.snp.top)
            $0.leading.equalTo(optionThirdButton.snp.trailing).offset(20)
        }

        optionThirdSubtitle.snp.makeConstraints {
            $0.top.equalTo(optionThirdTitle.snp.top)
            $0.leading.equalTo(optionThirdTitle.snp.trailing).offset(20)
        }
        
        // 버튼의 터치 영역을 설정합니다.
        optionFirstView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(optionFirstSelected)))
        optionSecondView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(optionSecondSelected)))
        optionThirdView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(optionThirdSelected)))

        // 기존의 selectedOption 값에 따라 버튼의 선택 여부를 설정합니다.
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
        // 원래는 버튼에 대한 addTarget을 여기서 설정하던 것을 사용하지 않습니다.
        // 대신 각 옵션 뷰에 터치 제스처를 추가하여 버튼의 선택을 처리합니다.
    }
    
    func dismissBottomSheet() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - @objc Methods

    @objc private func optionFirstSelected() {
        // 첫 번째 옵션 버튼을 탭할 때의 동작을 처리합니다.
        onOptionSelected?(optionFirstButton.tag)
        optionSecondButton.innerCircle.isHidden = true
        optionThirdButton.innerCircle.isHidden = true
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func optionSecondSelected() {
        // 두 번째 옵션 버튼을 탭할 때의 동작을 처리합니다.
        onOptionSelected?(optionSecondButton.tag)
        optionFirstButton.innerCircle.isHidden = true
        optionThirdButton.innerCircle.isHidden = true
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func optionThirdSelected() {
        // 세 번째 옵션 버튼을 탭할 때의 동작을 처리합니다.
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
