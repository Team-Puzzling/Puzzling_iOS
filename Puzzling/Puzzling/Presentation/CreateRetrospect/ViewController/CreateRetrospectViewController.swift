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
    
    private let tilView: TILView! = TILView()
    private let fiveFView = FiveFView()
    private let arrView = AARView()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setLayout()
        setUI()
        setAddTarget()
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
            $0.setTitle("TIL", for: .normal)
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
    }

    private func updateContentView(option: String) {
        print(option)
        switch option {
        case "TIL":
            contentView.subviews.forEach { $0.removeFromSuperview() }
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
            contentView.subviews.forEach { $0.removeFromSuperview() }
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
            contentView.subviews.forEach { $0.removeFromSuperview() }
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
    
    // MARK: - @objc Methods

    @objc func presnetToBottomSheetViewController() {
        let bottomSheetVC = BottomSheetViewController()
        bottomSheetVC.selectedOption = templatesButton.title(for: .normal)
        bottomSheetVC.onOptionSelected = { [weak self] option in
            self?.templatesButton.setTitle("\(option)", for: .normal)
            self?.updateContentView(option: option)
        }
        present(bottomSheetVC, animated: true, completion: nil)
    }

    
    @objc
    private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func saveButtonTapped() {

    }
}
