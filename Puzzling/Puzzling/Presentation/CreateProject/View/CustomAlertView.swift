//
//  CustomAlert.swift
//  Puzzling
//
//  Created by 천성우 on 2023/07/15.
//

import UIKit

import Then
import SnapKit

enum CustomAlertType {
    case createRetrospect
    case createProject
}

class CustomAlertView: UIView {

    // MARK: - Properties

    private let alertType: CustomAlertType
    var onSaveButtonTapped: (() -> Void)?

    // MARK: - UI Components

    private let containerView = UIView()
    private let contentView = UIView()
    private let logoImage = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let saveButton = UIButton()
    private let cancelButton = UIButton()
    private let copyButton = UIButton()
    private let kakaoShareButton = UIButton()
    private let closeButton = UIButton()


    // MARK: - Initializer

    init(frame: CGRect, alertType: CustomAlertType) {
        self.alertType = alertType
        super.init(frame: frame)
        setUI()
        setLayout()
        setAddTarget()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Components Property

    private func setUI(){

        self.backgroundColor = .background500

        containerView.do {
            $0.backgroundColor = .clear
        }

        contentView.do {
            $0.backgroundColor = .white000
            $0.layer.cornerRadius = 16
        }

        logoImage.do {
            $0.image = Image.elementPuzzle1
        }

        switch alertType {
        case .createRetrospect:
            titleLabel.do {
                $0.text = "회고를 저장할까요?"
                $0.font = .fontGuide(.heading4_kor)
                $0.textColor = .black000
            }

            subtitleLabel.do {
                $0.text = "수정이 어려우니\n신중하게 작성해 주세요!"
                $0.numberOfLines = 2
                $0.font = .fontGuide(.body3_regular_kor)
                $0.textColor = .gray600
                $0.textAlignment = .center
            }

            saveButton.do {
                $0.setTitle("저장하기", for: .normal)
                $0.setTitleColor(UIColor.white000, for: .normal)
                $0.titleLabel?.font = .fontGuide(.body1_bold_kor)
                $0.backgroundColor = .blue400
                $0.layer.cornerRadius = 16
            }

            cancelButton.do {
                $0.setTitle("취소", for: .normal)
                $0.setTitleColor(UIColor.gray700, for: .normal)
                $0.titleLabel?.font = .fontGuide(.body1_bold_kor)
                $0.backgroundColor = .background050
                $0.layer.cornerRadius = 16
            }

        case .createProject:
            titleLabel.do {
                $0.text = "초대코드가 생성되었어요!"
                $0.font = .fontGuide(.heading4_kor)
                $0.textColor = .black000
            }

            subtitleLabel.do {
                $0.text = "ABCDEFG"
                $0.numberOfLines = 2
                $0.font = .fontGuide(.body3_regular_kor)
                $0.textColor = .gray600
                $0.textAlignment = .center
            }

            copyButton.do {
                $0.setTitle("초대코드 복사하기", for: .normal)
                $0.setTitleColor(UIColor.white000, for: .normal)
                $0.titleLabel?.font = .fontGuide(.body1_bold_kor)
                $0.backgroundColor = .blue400
                $0.layer.cornerRadius = 16
            }

            kakaoShareButton.do {
                $0.setTitle("카카오톡으로 공유하기", for: .normal)
                $0.setTitleColor(UIColor.black000, for: .normal)
                $0.titleLabel?.font = .fontGuide(.body1_bold_kor)
                $0.backgroundColor = .background050
                $0.layer.cornerRadius = 16
            }

            closeButton.do {
                $0.setTitle("닫기", for: .normal)
                $0.setTitleColor(UIColor.gray500, for: .normal)
                $0.titleLabel?.font = .fontGuide(.body1_regular_kor)
                $0.backgroundColor = .clear
                $0.layer.cornerRadius = 16
            }
        }
    }


    // MARK: - Layout Helper

    private func setLayout() {

        switch alertType {
        case .createRetrospect:

            addSubviews(containerView)
            containerView.addSubviews(contentView, logoImage, titleLabel,
                                      subtitleLabel, saveButton, cancelButton)

            containerView.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(42)
                $0.trailing.equalToSuperview().inset(43)
                $0.centerY.equalToSuperview()
                $0.height.equalTo(340)
            }

            contentView.snp.makeConstraints {
                $0.top.equalTo(containerView.snp.top).inset(32)
                $0.bottom.equalTo(containerView.snp.bottom)
                $0.leading.trailing.equalToSuperview()
            }

            logoImage.snp.makeConstraints {
                $0.top.equalTo(containerView.snp.top)
                $0.centerX.equalTo(containerView)
                $0.width.equalTo(78)
                $0.height.equalTo(77)
            }

            titleLabel.snp.makeConstraints {
                $0.top.equalTo(contentView.snp.top).inset(70)
                $0.centerX.equalTo(containerView)
            }

            subtitleLabel.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).inset(-8)
                $0.centerX.equalTo(containerView)
            }

            saveButton.snp.makeConstraints {
                $0.top.equalTo(subtitleLabel.snp.bottom).inset(-30)
                $0.leading.trailing.equalToSuperview().inset(24)
                $0.height.equalTo(50)
            }

            cancelButton.snp.makeConstraints {
                $0.top.equalTo(saveButton.snp.bottom).inset(-8)
                $0.leading.trailing.equalToSuperview().inset(24)
                $0.height.equalTo(50)
            }
        case .createProject:

            addSubviews(containerView)
            containerView.addSubviews(contentView, logoImage, titleLabel,
                                      subtitleLabel, copyButton, kakaoShareButton,
                                      closeButton)

            containerView.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(42)
                $0.trailing.equalToSuperview().inset(43)
                $0.centerY.equalToSuperview()
                $0.height.equalTo(373)
            }

            contentView.snp.makeConstraints {
                $0.top.equalTo(containerView.snp.top).inset(32)
                $0.bottom.equalTo(containerView.snp.bottom)
                $0.leading.trailing.equalToSuperview()
            }

            logoImage.snp.makeConstraints {
                $0.top.equalTo(containerView.snp.top)
                $0.centerX.equalTo(containerView)
                $0.width.equalTo(78)
                $0.height.equalTo(77)
            }

            titleLabel.snp.makeConstraints {
                $0.top.equalTo(contentView.snp.top).inset(70)
                $0.centerX.equalTo(containerView)
            }

            subtitleLabel.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(12)
                $0.centerX.equalTo(containerView)
            }

            copyButton.snp.makeConstraints {
                $0.top.equalTo(subtitleLabel.snp.bottom).offset(30)
                $0.leading.trailing.equalToSuperview().inset(24)
                $0.height.equalTo(50)
            }

            kakaoShareButton.snp.makeConstraints {
                $0.top.equalTo(copyButton.snp.bottom).offset(10)
                $0.leading.trailing.equalTo(copyButton)
                $0.height.equalTo(50)
            }

            closeButton.snp.makeConstraints {
                $0.top.equalTo(kakaoShareButton.snp.bottom).offset(10)
                $0.leading.trailing.equalTo(copyButton)
                $0.height.equalTo(50)
            }
        }
    }

    // MARK: - Methods

    private func setAddTarget() {
        switch alertType {
        case .createRetrospect:
            saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
            cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        case .createProject:
            copyButton.addTarget(self, action: #selector(copyButtonTapped), for: .touchUpInside)
            closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        }
    }

    private func closeAlertView() {
        removeFromSuperview()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let navigationController = windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController as? UINavigationController {
            navigationController.navigationBar.isUserInteractionEnabled = true
        }
    }

    // MARK: - @objc Methods

    @objc
    private func cancelButtonTapped() {
        closeAlertView()
    }

    @objc
    private func kakaoShareButtonTapped() {
        print("kakaoShareButtonTapped")
    }

    @objc
    private func closeButtonTapped() {
        closeAlertView()
    }
    
    @objc
    private func saveButtonTapped() {
        onSaveButtonTapped?()
    }

    @objc
    private func copyButtonTapped() {
        let text = subtitleLabel.text
        let pasteboard = UIPasteboard.general
        pasteboard.string = text
        closeAlertView()
    }
}

