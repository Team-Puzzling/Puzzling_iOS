//
//  CreateReViewViewController.swift
//  Puzzling
//
//  Created by 천성우 on 2023/07/10.
//

import UIKit

import Moya
import Then
import SnapKit

final class CreateReViewViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let templatesButton = UIButton()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private var tilView: TILView! = TILView()
    private var fiveFView: FiveFView! = FiveFView()
    private var arrView: AARView! = AARView()
    
    private var option = 0
    private var templateID = 1
    private var keyboardOverlapKey: Int? = 0
    private var projectTitle: String = ""
    
    let previousTemplateProvider = MoyaProvider<CreateRetrospectService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    private var previousTemplateId: PreviousTemplateModel?
    private let reviewProvider = MoyaProvider<CreateRetrospectService>(plugins:[NetworkLoggerPlugin()])
    
    private var reviewTILModel: ReviewTILModel
    private var reviewFiveFModel: ReviewFiveFModel
    private var reviewAARModel: ReviewAARModel

    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPreviousTemplate()
        setLayout()
        setUI()
        setupKeyboardEvent()
        setAddTarget()
        setTapScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
          super.viewDidAppear(animated)
        updateContentView(option: option)
      }
    
    init() {
        reviewTILModel = ReviewTILModel(reviewTemplateId: 0, liked: "", lacked: "", actionPlan: "")
        reviewFiveFModel = ReviewFiveFModel(reviewTemplateId: 0, fact: "", feeling: "",
                                            finding: "", feedback: "", actionPlan: "")
        reviewAARModel = ReviewAARModel(reviewTemplateId: 0, initialGoal: "", result: "",
                                        difference: "", persistence: "", actionPlan: "")
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - deinit
    
    deinit {
        print("CreateRetrospectViewController deinit")
    }
}

extension CreateReViewViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        view.backgroundColor = .white
        
        templatesButton.do {
            $0.backgroundColor = .background050
            $0.setTitleColor(UIColor.gray700, for: .normal)
            $0.titleLabel?.font = .fontGuide(.body1_bold_kor)
            $0.setImage(Image.chevronDown, for: .normal)
            $0.layer.cornerRadius = 16
            $0.tintColor = .gray700
            var config = UIButton.Configuration.plain()
            config.imagePlacement = NSDirectionalRectEdge.trailing
            
            templatesButton.configuration = config
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        contentView.addSubviews(templatesButton)
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(716)
        }
        
        templatesButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(18)
            $0.height.equalTo(36)
        }
    }
    
    // MARK: - Methods
    
    private func setNavigation() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .gray500
        navigationItem.title = projectTitle
        let backButton = UIBarButtonItem(image: Image.chevronBack, style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.imageInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
        navigationItem.leftBarButtonItem = backButton
        let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveNavigationButtonTapped))
        saveButton.tintColor = .gray400
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        tilView.onCompletionTIL = { [weak self] shouldPrint in
            if shouldPrint {
                self?.navigationItem.rightBarButtonItem?.isEnabled = true
                self?.navigationItem.rightBarButtonItem?.tintColor = .blue400
            } else {
                self?.navigationItem.rightBarButtonItem?.isEnabled = false
                self?.navigationItem.rightBarButtonItem?.tintColor = .gray400
            }
        }
        
        fiveFView.onCompletionFiveF = { [weak self] shouldPrint in
            if shouldPrint {
                self?.navigationItem.rightBarButtonItem?.isEnabled = true
                self?.navigationItem.rightBarButtonItem?.tintColor = .blue400
            } else {
                self?.navigationItem.rightBarButtonItem?.isEnabled = false
                self?.navigationItem.rightBarButtonItem?.tintColor = .gray400
            }
        }
        
        arrView.onCompletionAAR = { [weak self] shouldPrint in
            if shouldPrint {
                self?.navigationItem.rightBarButtonItem?.isEnabled = true
                self?.navigationItem.rightBarButtonItem?.tintColor = .blue400
            } else {
                self?.navigationItem.rightBarButtonItem?.isEnabled = false
                self?.navigationItem.rightBarButtonItem?.tintColor = .gray400
            }
        }
    }
    
    private func updateContentView(option: Int) {
        
        contentView.subviews.forEach { $0.removeFromSuperview() } // 기존의 모든 서브뷰를 제거합니다.
        templateID = option
        print(templateID)
        print(option)
        
        
        switch option {
            
        case 1:
            
            setNavigation()
            templatesButton.setTitle("TIL", for: .normal)
            contentView.addSubviews(templatesButton, tilView)
            
            contentView.snp.updateConstraints {
                $0.edges.equalToSuperview()
                $0.width.equalToSuperview()
                $0.height.equalTo(716)
            }
            
            templatesButton.snp.makeConstraints {
                $0.top.equalToSuperview().inset(16)
                $0.leading.equalToSuperview().inset(18)
                $0.height.equalTo(36)
            }
            
            tilView.snp.makeConstraints {
                $0.top.equalTo(templatesButton.snp.bottom).inset(-24)
                $0.leading.trailing.bottom.equalToSuperview()
            }
            
            
        case 2:
            
            setNavigation()
            templatesButton.setTitle("5F", for: .normal)
            contentView.addSubviews(templatesButton, fiveFView)
            
            contentView.snp.updateConstraints {
                $0.edges.equalToSuperview()
                $0.width.equalToSuperview()
                $0.height.equalTo(1163)
            }
            
            templatesButton.snp.makeConstraints {
                $0.top.equalToSuperview().inset(16)
                $0.leading.equalToSuperview().inset(18)
                $0.height.equalTo(36)
            }
            
            fiveFView.snp.makeConstraints {
                $0.top.equalTo(templatesButton.snp.bottom).inset(-24)
                $0.leading.trailing.bottom.equalToSuperview()
            }
            
        case 3:
            
            setNavigation()
            templatesButton.setTitle("AAR", for: .normal)
            contentView.addSubviews(templatesButton, arrView)
            
            contentView.snp.updateConstraints {
                $0.edges.equalToSuperview()
                $0.width.equalToSuperview()
                $0.height.equalTo(1163)
            }
            
            templatesButton.snp.makeConstraints {
                $0.top.equalToSuperview().inset(16)
                $0.leading.equalToSuperview().inset(18)
                $0.height.equalTo(36)
            }
            
            arrView.snp.makeConstraints {
                $0.top.equalTo(templatesButton.snp.bottom).inset(-24)
                $0.leading.trailing.bottom.equalToSuperview()
            }
            
        default:
            break
        }
    }
    
    private func setAddTarget() {
        templatesButton.addTarget(self, action: #selector(presnetToBottomSheetViewController), for: .touchUpInside)
    }
    
    private func setTapScreen() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapScreen))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
        
    private func setOptionSelected(option: Int) {
        templateID = option
    }
    
    private func setupKeyboardEvent() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    // MARK: - @objc Methods
    
    @objc
    func keyboardWillShow(_ sender: Notification) {
        guard let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextView = UIResponder.currentResponder as? UITextView else { return }
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextViewFrame = view.convert(currentTextView.frame, from: currentTextView.superview)
        let textViewBottomY = convertedTextViewFrame.origin.y + convertedTextViewFrame.size.height
        
        if textViewBottomY > keyboardTopY {
            let keyboardOverlap = textViewBottomY - keyboardTopY
            scrollView.contentOffset.y += keyboardOverlap + 40
            self.keyboardOverlapKey = 40
        }
    }
    
    @objc
    func keyboardWillHide(_ sender: Notification) {
        
        switch self.templateID {
        case 1:
            scrollView.contentOffset.y = 0
            print(templateID)
        case 2:
            if scrollView.contentOffset.y != 0 {
                scrollView.contentOffset.y -= 40
            }
        case 3:
            if scrollView.contentOffset.y != 0 {
                scrollView.contentOffset.y -= 40
            }
        default:
            return
        }
    }
    
    @objc
    private func didTapScreen() {
        view.endEditing(true)
    }
    
    @objc
    func presnetToBottomSheetViewController() {
        let bottomSheetVC = BottomSheetViewController()
        bottomSheetVC.selectedOption = templatesButton.title(for: .normal)
        bottomSheetVC.onOptionSelected = { [weak self] option in
            self?.templatesButton.setTitle("\(option)", for: .normal)
            self?.updateContentView(option: option)
        }
        present(bottomSheetVC, animated: true, completion: nil)
        
        tilView = TILView()
        fiveFView = FiveFView()
        arrView = AARView()
    }
    
    
    @objc
    private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func saveButtonTapped() {
//        showToast(message: "저장 완료!")
        let templateID = self.templateID
            switch templateID {
            case 1:
                print("1번 옵션이 선택 되었습니다")
                
                guard let liked = self.tilView.wellTextView.text else { return }
                guard let lacked = self.tilView.regretTextView.text else { return }
                guard let actionPlan = self.tilView.learnTextView.text else { return }
                
                postReviewTIL(reviewTemplateId: templateID, liked: liked, lacked: lacked,
                              actionPlan: actionPlan)
            case 2:
                print("2번 옵션이 선택 되었습니다")
                
                guard let fact = self.fiveFView.factTextView.text else { return }
                guard let feeling = self.fiveFView.feelingTextView.text else { return }
                guard let finding = self.fiveFView.findingTextView.text else { return }
                guard let feedback = self.fiveFView.feedbackTextView.text else { return }
                guard let actionPlan = self.fiveFView.futureTextView.text else { return }
            
                postReviewFiveF(reviewTemplateId: templateID, fact: fact, feeling: feeling,
                                finding: finding, feedback: feedback, actionPlan: actionPlan)
            case 3:
                print("3번 옵션이 선택 되었습니다")
                
                guard let initialGoal = self.arrView.targetTextView.text else { return }
                guard let result = self.arrView.resultTextView.text else { return }
                guard let difference = self.arrView.differenceTextView.text else { return }
                guard let persistence = self.arrView.continuouslyTextView.text else { return }
                guard let actionPlan = self.arrView.purposeTextView.text else { return }
                
                postReviewAAR(reviewTemplateId: templateID, initialGoal: initialGoal, result: result,
                              difference: difference, persistence: persistence, actionPlan: actionPlan)
            default:
                break
            }
        
    }
    
    @objc
    func saveNavigationButtonTapped() {
        print(templateID)
        navigationController?.navigationBar.isUserInteractionEnabled = false
        let alert = CustomAlertView(frame: CGRect(x: 0, y: 0, width: 300, height: 400), alertType: .createRetrospect)
        alert.translatesAutoresizingMaskIntoConstraints = false
        alert.onSaveButtonTapped = { [weak self] in // Assign the handler closure
            self?.saveButtonTapped()
        }
        view.addSubview(alert)
        
        alert.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        alert.isUserInteractionEnabled = true
    }
}

extension CreateReViewViewController {
    
    // MARK: - Network
    
        func fetchPreviousTemplate() {
            previousTemplateProvider.request(.previousTemplate(memberID: "7", projectID: "2")) { result in
                switch result {
                case .success(let result):
                    let status = result.statusCode
                    if status >= 200 && status < 300 {
                        do {
                            guard let data = try result.map(GeneralResponse<PreviousTemplateResponce>.self).data else {
                                return
                            }
    
                            self.previousTemplateId = data.convertToPreviousTemplate()
                            let template = data
                            print(template)
                            print("♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️")
                            print(self.previousTemplateId)
                            if let templateNum = self.previousTemplateId?.previousTemplateId {
                                print("이전에 작성한 회고 Option은~")
                                print("♥️♥️♥️♥️ \(templateNum) 입니다♥️♥️♥️♥️")
                                self.option = templateNum
    
                            }
                        }
                        catch (let error) {
                            print(error.localizedDescription)
                        }
                    }
                    else if status >= 400 {
                        print("💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭")
                        print("400 이상에러")
                        print("💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    
    private func postReviewTIL(reviewTemplateId: Int, liked: String, lacked: String, actionPlan: String) {
        reviewTILModel.reviewTemplateId = reviewTemplateId
        reviewTILModel.liked = liked
        reviewTILModel.lacked = lacked
        reviewTILModel.actionPlan = actionPlan
        
        reviewProvider.request(.reviewTIL(param: reviewTILModel.makePostReviewTILResponce(), memberID: "7", projectID: "2")) { result in
            switch result {
            case .success(let result):
                let status = result.statusCode
                if status >= 200 && status < 300 {
                    do {
                        print("🪀🪀🪀🪀🪀🪀🪀🪀🪀🪀🪀🪀🪀🪀")
                        self.navigationController?.popViewController(animated: true)
                        print("🪀🪀🪀성공적으로 저장 후 화면 전환🪀🪀🪀")
                        print("🪀🪀🪀🪀🪀🪀🪀🪀🪀🪀🪀🪀🪀🪀")

                    } catch(let error){
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
    
    private func postReviewFiveF(reviewTemplateId: Int, fact: String, feeling: String, finding: String, feedback: String, actionPlan: String) {
        reviewFiveFModel.reviewTemplateId = reviewTemplateId
        reviewFiveFModel.fact = fact
        reviewFiveFModel.feeling = feeling
        reviewFiveFModel.finding = finding
        reviewFiveFModel.feedback = feedback
        reviewFiveFModel.actionPlan = actionPlan
        
        reviewProvider.request(.reviewFiveF(param: reviewFiveFModel.makePostReviewFiveFResponce(), memberID: "7", projectID: "2")) { result in
            switch result {
            case .success(let result):
                let status = result.statusCode
                if status >= 200 && status < 300 {
                    do {
                        print("🪀🪀🪀🪀🪀🪀🪀🪀🪀🪀🪀🪀🪀🪀")
                        self.navigationController?.popViewController(animated: true)
                        print("🪀🪀🪀성공적으로 저장 후 화면 전환🪀🪀🪀")
                        print("🪀🪀🪀🪀🪀🪀🪀🪀🪀🪀🪀🪀🪀🪀")

                    } catch(let error){
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
    
    private func postReviewAAR(reviewTemplateId: Int, initialGoal: String, result: String, difference: String,
                               persistence: String, actionPlan: String) {
        reviewAARModel.reviewTemplateId = reviewTemplateId
        reviewAARModel.initialGoal = initialGoal
        reviewAARModel.result = result
        reviewAARModel.difference = difference
        reviewAARModel.persistence = persistence
        reviewAARModel.actionPlan = actionPlan
        
        reviewProvider.request(.reivewAAR(param: reviewAARModel.makePostReviewAARResponce(), memberID: "7", projectID: "2")) { result in
            switch result {
            case .success(let result):
                let status = result.statusCode
                if status >= 200 && status < 300 {
                    do {
                        print("🪀🪀🪀🪀🪀🪀🪀🪀🪀🪀🪀🪀🪀🪀")
                        self.navigationController?.popViewController(animated: true)
                        print("🪀🪀🪀성공적으로 저장 후 화면 전환🪀🪀🪀")
                        print("🪀🪀🪀🪀🪀🪀🪀🪀🪀🪀🪀🪀🪀🪀")

                    } catch(let error){
                        print(error.localizedDescription)
                    }
                }
                else if status >= 400 {
                    print("⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️")
                    print(status)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension CreateReViewViewController {
    func passProjectTitle(title: String) {
        self.projectTitle = title
    }
}
