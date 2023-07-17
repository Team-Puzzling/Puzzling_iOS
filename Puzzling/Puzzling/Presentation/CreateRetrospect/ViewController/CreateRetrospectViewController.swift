//
//  CreateRetrospectViewController.swift
//  Puzzling
//
//  Created by 천성우 on 2023/07/10.
//

import UIKit

import Then
import SnapKit

final class CreateRetrospectViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let templatesButton = UIButton()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private var tilView: TILView! = TILView()
    private var fiveFView: FiveFView! = FiveFView()
    private var arrView: AARView! = AARView()
    
    private let option: String
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setLayout()
        setUI()
        setupKeyboardEvent()
        setAddTarget()
        setTapScreen()
        updateContentView(option: option)
    }
    
    init(option: String) {
        self.option = option
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

extension CreateRetrospectViewController {
    
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
        
        contentView.addSubviews(templatesButton, tilView)
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
        
        tilView.snp.makeConstraints {
            $0.top.equalTo(templatesButton.snp.bottom).inset(-24)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    private func setNavigation() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .gray500
        navigationItem.title = "프로젝트 이름"
        let backButton = UIBarButtonItem(image: Image.chevronBack, style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.imageInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
        navigationItem.leftBarButtonItem = backButton
        let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
        saveButton.tintColor = .gray400
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        tilView.onCompletionTIL = { [weak self] shouldPrint in
            if shouldPrint {
                print("나와랑")
                // Enable the save button
                self?.navigationItem.rightBarButtonItem?.isEnabled = true
                self?.navigationItem.rightBarButtonItem?.tintColor = .blue400
            } else {
                // Disable the save button
                self?.navigationItem.rightBarButtonItem?.isEnabled = false
                self?.navigationItem.rightBarButtonItem?.tintColor = .gray400
            }
        }
        
        fiveFView.onCompletionFiveF = { [weak self] shouldPrint in
            if shouldPrint {
                print("나와랑")
                // Enable the save button
                self?.navigationItem.rightBarButtonItem?.isEnabled = true
                self?.navigationItem.rightBarButtonItem?.tintColor = .blue400
            } else {
                // Disable the save button
                self?.navigationItem.rightBarButtonItem?.isEnabled = false
                self?.navigationItem.rightBarButtonItem?.tintColor = .gray400
            }
        }
        
        arrView.onCompletionAAR = { [weak self] shouldPrint in
            if shouldPrint {
                print("나와랑")
                // Enable the save button
                self?.navigationItem.rightBarButtonItem?.isEnabled = true
                self?.navigationItem.rightBarButtonItem?.tintColor = .blue400
            } else {
                // Disable the save button
                self?.navigationItem.rightBarButtonItem?.isEnabled = false
                self?.navigationItem.rightBarButtonItem?.tintColor = .gray400
            }
        }
    }
    
    private func updateContentView(option: String) {
        print(option)
        templatesButton.setTitle(option, for: .normal)

        contentView.subviews.forEach { $0.removeFromSuperview() } // 기존의 모든 서브뷰를 제거합니다.

        switch option {
        case "TIL":
            setNavigation()
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
            
        case "5F":
            setNavigation()
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
            
        case "AAR":
            setNavigation()
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
        
        tilView = nil
        fiveFView = nil
        arrView = nil
    }
    
    private func setAddTarget() {
        templatesButton.addTarget(self, action: #selector(presnetToBottomSheetViewController), for: .touchUpInside)
    }
    
    private func setTapScreen() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapScreen))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setupKeyboardEvent() {
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
    
    @objc func keyboardWillShow(_ sender: Notification) {
        guard let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextView = UIResponder.currentResponder as? UITextView else { return }
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextViewFrame = view.convert(currentTextView.frame, from: currentTextView.superview)
        let textViewBottomY = convertedTextViewFrame.origin.y + convertedTextViewFrame.size.height
        
        if textViewBottomY > keyboardTopY {
            let keyboardOverlap = textViewBottomY - keyboardTopY
            view.frame.origin.y = -keyboardOverlap - 40
        }
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
    
    @objc private func didTapScreen() {
        view.endEditing(true)
    }
    
    @objc func presnetToBottomSheetViewController() {
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
        navigationController?.navigationBar.isUserInteractionEnabled = false

        let alert = CustomAlertView(frame: CGRect(x: 0, y: 0, width: 300, height: 400), alertType: .createRetrospect)
        alert.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(alert)

        alert.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        alert.isUserInteractionEnabled = true
    }
}
