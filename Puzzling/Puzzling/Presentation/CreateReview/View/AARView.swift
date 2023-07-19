//
//  AARView.swift
//  Puzzling
//
//  Created by 천성우 on 2023/07/10.
//

import UIKit

import Then
import SnapKit

class AARView: UIView {
    
    // MARK: - UI Components
    
    private let targetLabel = UILabel()
    private let resultLabel = UILabel()
    private let differenceLabel = UILabel()
    private let continuouslyLabel = UILabel()
    private let purposeLabel = UILabel()
    
    private let targetNumLabel = UILabel()
    private let resultNumLabel = UILabel()
    private let differenceNumLabel = UILabel()
    private let continuouslyNumLabel = UILabel()
    private let purposeNumLabel = UILabel()
    
    let targetTextView = UITextView()
    let resultTextView = UITextView()
    let differenceTextView = UITextView()
    let continuouslyTextView = UITextView()
    let purposeTextView = UITextView()
    
    private let errorTargetLabel = UILabel()
    private let errorResultLabel = UILabel()
    private let errorDifferenceLabel = UILabel()
    private let errorContinuouslyLabel = UILabel()
    private let errorPurposeLabel = UILabel()
    
    // MARK: - Properties

    private let targetPlaceholder: String = "\"업무 전에 의도한 혹은 얻고자 한 결과는 무엇이었는지\" 작성해요."
    private let resultPlaceholder: String = "\"실제로 오늘 하루 어떤 일이 있었는지\" 작성해요."
    private let differencePlaceholder: String = "\"목표와 실제 결과 사이의 차이는 왜 발생했을지\" 작성해요."
    private let continuouslyPlaceholder: String = "\"지속하고 싶은 부분은 무엇인지\" 작성해요."
    private let purposePlaceholder: String = "\"개선하거나 포기해야 할 부분은 무엇인지\" 작성해요."
    
    var onCompletionAAR: ((Bool) -> Void)?
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setUI()
        setDelegate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}

extension AARView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        self.backgroundColor = .white000
        
        targetLabel.do {
            $0.text = "초기의 목표는 무엇이었나요?"
            $0.textColor = .black000
            $0.font = .fontGuide(.body1_bold_kor)
        }
        
        resultLabel.do {
            $0.text = "결과는 어땠나요?"
            $0.textColor = .black000
            $0.font = .fontGuide(.body1_bold_kor)
        }
        
        differenceLabel.do {
            $0.text = "차이가 왜 발생했을까요?"
            $0.textColor = .black000
            $0.font = .fontGuide(.body1_bold_kor)
        }
        
        continuouslyLabel.do {
            $0.text = "어떤 점을 지속하고 싶나요?"
            $0.textColor = .black000
            $0.font = .fontGuide(.body1_bold_kor)
        }
        
        purposeLabel.do {
            $0.text = "앞으로의 목적은 무엇인가요?"
            $0.textColor = .black000
            $0.font = .fontGuide(.body1_bold_kor)
        }
        
        targetNumLabel.do {
            $0.text = "0/200"
            $0.textAlignment = .right
            $0.textColor = .gray400
            $0.font = .fontGuide(.detail3_regular_kor)
        }
        
        resultNumLabel.do {
            $0.text = "0/200"
            $0.textAlignment = .right
            $0.textColor = .gray400
            $0.font = .fontGuide(.detail3_regular_kor)
        }
        
        differenceNumLabel.do {
            $0.text = "0/200"
            $0.textAlignment = .right
            $0.textColor = .gray400
            $0.font = .fontGuide(.detail3_regular_kor)
        }
        
        continuouslyNumLabel.do {
            $0.text = "0/200"
            $0.textAlignment = .right
            $0.textColor = .gray400
            $0.font = .fontGuide(.detail3_regular_kor)
        }
        
        purposeNumLabel.do {
            $0.text = "0/200"
            $0.textAlignment = .right
            $0.textColor = .gray400
            $0.font = .fontGuide(.detail3_regular_kor)
        }
        
        targetTextView.do {
            $0.text = targetPlaceholder
            $0.textColor = .gray400
            $0.backgroundColor = UIColor.background050
            $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            $0.layer.cornerRadius = 16
            $0.font = .fontGuide(.body2_regular_kor)
        }
        
        resultTextView.do {
            $0.text = resultPlaceholder
            $0.textColor = .gray400
            $0.backgroundColor = UIColor.background050
            $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            $0.layer.cornerRadius = 16
            $0.font = .fontGuide(.body2_regular_kor)
        }
        
        differenceTextView.do {
            $0.text = differencePlaceholder
            $0.textColor = .gray400
            $0.backgroundColor = UIColor.background050
            $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            $0.layer.cornerRadius = 16
            $0.font = .fontGuide(.body2_regular_kor)
        }
        
        continuouslyTextView.do {
            $0.text = continuouslyPlaceholder
            $0.textColor = .gray400
            $0.backgroundColor = UIColor.background050
            $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            $0.layer.cornerRadius = 16
            $0.font = .fontGuide(.body2_regular_kor)
        }
        
        purposeTextView.do {
            $0.text = purposePlaceholder
            $0.textColor = .gray400
            $0.backgroundColor = UIColor.background050
            $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            $0.layer.cornerRadius = 16
            $0.font = .fontGuide(.body2_regular_kor)
        }
        
        errorTargetLabel.do {
            $0.text = "이모지를 사용할 수 없어요."
            $0.textColor = .red400
            $0.font = .fontGuide(.detail1_regular_kor)
            $0.isHidden = true
        }
        
        errorResultLabel.do {
            $0.text = "이모지를 사용할 수 없어요."
            $0.textColor = .red400
            $0.font = .fontGuide(.detail1_regular_kor)
            $0.isHidden = true
        }
        
        errorDifferenceLabel.do {
            $0.text = "이모지를 사용할 수 없어요."
            $0.textColor = .red400
            $0.font = .fontGuide(.detail1_regular_kor)
            $0.isHidden = true
        }
        
        errorContinuouslyLabel.do {
            $0.text = "이모지를 사용할 수 없어요."
            $0.textColor = .red400
            $0.font = .fontGuide(.detail1_regular_kor)
            $0.isHidden = true
        }
        
        errorPurposeLabel.do {
            $0.text = "이모지를 사용할 수 없어요."
            $0.textColor = .red400
            $0.font = .fontGuide(.detail1_regular_kor)
            $0.isHidden = true
        }
        
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        addSubviews(targetLabel, resultLabel, differenceLabel,
                    continuouslyLabel, purposeLabel, targetTextView,
                    resultTextView, differenceTextView, continuouslyTextView,
                    purposeTextView, targetNumLabel, resultNumLabel,
                    differenceNumLabel, continuouslyNumLabel, purposeNumLabel,
                    errorTargetLabel, errorResultLabel, errorDifferenceLabel,
                    errorContinuouslyLabel, errorPurposeLabel)
        
        targetLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(24)
        }
        
        targetTextView.snp.makeConstraints {
            $0.top.equalTo(targetLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(118)
        }
        
        targetNumLabel.snp.makeConstraints {
            $0.top.equalTo(targetTextView.snp.bottom).inset(-4)
            $0.trailing.equalTo(targetTextView.snp.trailing).inset(16)
        }
        
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(targetTextView.snp.bottom).offset(45)
            $0.leading.equalToSuperview().offset(24)
        }
        
        resultTextView.snp.makeConstraints {
            $0.top.equalTo(resultLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(118)
        }
        
        resultNumLabel.snp.makeConstraints {
            $0.top.equalTo(resultTextView.snp.bottom).inset(-4)
            $0.trailing.equalTo(resultTextView.snp.trailing).inset(16)
        }
        
        differenceLabel.snp.makeConstraints {
            $0.top.equalTo(resultTextView.snp.bottom).offset(45)
            $0.leading.equalToSuperview().offset(24)
        }
        
        differenceTextView.snp.makeConstraints {
            $0.top.equalTo(differenceLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(118)
        }
        
        differenceNumLabel.snp.makeConstraints {
            $0.top.equalTo(differenceTextView.snp.bottom).inset(-4)
            $0.trailing.equalTo(differenceTextView.snp.trailing).inset(16)
        }
        
        continuouslyLabel.snp.makeConstraints {
            $0.top.equalTo(differenceTextView.snp.bottom).offset(45)
            $0.leading.equalToSuperview().offset(24)
        }
        
        continuouslyTextView.snp.makeConstraints {
            $0.top.equalTo(continuouslyLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(118)
        }
        
        continuouslyNumLabel.snp.makeConstraints {
            $0.top.equalTo(continuouslyTextView.snp.bottom).inset(-4)
            $0.trailing.equalTo(continuouslyTextView.snp.trailing).inset(16)
        }
        
        purposeLabel.snp.makeConstraints {
            $0.top.equalTo(continuouslyTextView.snp.bottom).offset(45)
            $0.leading.equalToSuperview().offset(24)
        }
        
        purposeTextView.snp.makeConstraints {
            $0.top.equalTo(purposeLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(118)
        }
        
        purposeNumLabel.snp.makeConstraints {
            $0.top.equalTo(purposeTextView.snp.bottom).inset(-4)
            $0.trailing.equalTo(continuouslyTextView.snp.trailing).inset(16)
        }
        
        errorTargetLabel.snp.makeConstraints {
            $0.top.equalTo(targetTextView.snp.bottom).inset(-4)
            $0.leading.equalToSuperview().inset(24)
        }
        
        errorResultLabel.snp.makeConstraints {
            $0.top.equalTo(resultTextView.snp.bottom).inset(-4)
            $0.leading.equalToSuperview().inset(24)
        }
        
        errorDifferenceLabel.snp.makeConstraints {
            $0.top.equalTo(differenceTextView.snp.bottom).inset(-4)
            $0.leading.equalToSuperview().inset(24)
        }
        
        errorContinuouslyLabel.snp.makeConstraints {
            $0.top.equalTo(continuouslyTextView.snp.bottom).inset(-4)
            $0.leading.equalToSuperview().inset(24)
        }
        
        errorPurposeLabel.snp.makeConstraints {
            $0.top.equalTo(purposeTextView.snp.bottom).inset(-4)
            $0.leading.equalToSuperview().inset(24)
        }
    }
    
    // MARK: - Methods
    
    private func setDelegate() {
        targetTextView.delegate = self
        resultTextView.delegate = self
        differenceTextView.delegate = self
        continuouslyTextView.delegate = self
        purposeTextView.delegate = self
    }
    
    private func setErrorHidden(for textView: UITextView, isHidden: Bool) {
        switch textView {
        case targetTextView:
            errorTargetLabel.isHidden = isHidden
        case resultTextView:
            errorResultLabel.isHidden = isHidden
        case differenceTextView:
            errorDifferenceLabel.isHidden = isHidden
        case continuouslyTextView:
            errorContinuouslyLabel.isHidden = isHidden
        case purposeTextView:
            errorPurposeLabel.isHidden = isHidden
        default:
            break
        }
    }
}

extension AARView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView == targetTextView || textView == resultTextView || textView == differenceTextView || textView == continuouslyTextView || textView == purposeTextView {
            let isValid = textView.text.isOnlyKorEngSpe()
            if isValid {
                textView.layer.borderColor = UIColor.blue200.cgColor
                setErrorHidden(for: textView, isHidden: true)
            } else {
                textView.layer.borderColor = UIColor.red200.cgColor
                setErrorHidden(for: textView, isHidden: false)
                onCompletionAAR?(false)
            }
        }
        
        if textView == targetTextView {
            let textCount = textView.text.count
            targetNumLabel.text = "\(textCount)/200"
            if textCount > 200 {
                textView.deleteBackward()
            }
        } else if textView == resultTextView {
            let textCount = textView.text.count
            resultNumLabel.text = "\(textCount)/200"
            if textCount > 200 {
                textView.deleteBackward()
            }
        } else if textView == differenceTextView {
            let textCount = textView.text.count
            differenceNumLabel.text = "\(textCount)/200"
            if textCount > 200 {
                textView.deleteBackward()
            }
        } else if textView == continuouslyTextView {
            let textCount = textView.text.count
            continuouslyNumLabel.text = "\(textCount)/200"
            if textCount > 200 {
                textView.deleteBackward()
            }
        } else if textView == purposeTextView {
            let textCount = textView.text.count
            purposeNumLabel.text = "\(textCount)/200"
            if textCount > 200 {
                textView.deleteBackward()
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView == targetTextView || textView == resultTextView || textView == differenceTextView || textView == continuouslyTextView || textView == purposeTextView
        {
            let isValid = textView.text.isOnlyKorEngSpe()
            if isValid {
                textView.layer.borderColor = UIColor.blue200.cgColor
                setErrorHidden(for: textView, isHidden: true)
            } else {
                textView.layer.borderColor = UIColor.red200.cgColor
                setErrorHidden(for: textView, isHidden: false)
                onCompletionAAR?(false)
            }
        }
        textView.layer.borderWidth = 2.0
        
        if textView == targetTextView {
            if textView.textColor == .gray400 {
                textView.text = nil
                textView.textColor = .black000
                textView.font = .fontGuide(.body2_regular_kor)
            }
        } else if textView == resultTextView {
            if textView.textColor == .gray400{
                textView.text = nil
                textView.textColor = .black000
                textView.font = .fontGuide(.body2_regular_kor)
            }
        }
        else if textView == differenceTextView {
            if textView.textColor == .gray400 {
                textView.text = nil
                textView.textColor = .black000
                textView.font = .fontGuide(.body2_regular_kor)
            }
        }
        else if textView == continuouslyTextView {
            if textView.textColor == .gray400 {
                textView.text = nil
                textView.textColor = .black000
                textView.font = .fontGuide(.body2_regular_kor)
            }
        }
        else if textView == purposeTextView {
            if textView.textColor == .gray400 {
                textView.text = nil
                textView.textColor = .black000
                textView.font = .fontGuide(.body2_regular_kor)
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView == targetTextView || textView == resultTextView || textView == differenceTextView || textView == continuouslyTextView || textView == purposeTextView {
            let isValid = textView.text.isOnlyKorEngSpe()
            if isValid {
                textView.layer.borderColor = UIColor.clear.cgColor
                setErrorHidden(for: textView, isHidden: true)
                textView.layer.borderWidth = 0.0
                
            } else {
                textView.layer.borderColor = UIColor.red200.cgColor
                textView.layer.borderWidth = 2.0
                setErrorHidden(for: textView, isHidden: false)
                onCompletionAAR?(false)
            }
        }
        
        if textView == targetTextView {
            if textView.text.isEmpty {
                textView.text = targetPlaceholder
                textView.textColor = .gray400
            }
        } else if textView == resultTextView {
            if textView.text.isEmpty {
                textView.text = resultPlaceholder
                textView.textColor = .gray400
            }
        } else if textView == differenceTextView {
            if textView.text.isEmpty {
                textView.text = differencePlaceholder
                textView.textColor = .gray400
            }
        } else if textView == continuouslyTextView {
            if textView.text.isEmpty {
                textView.text = continuouslyPlaceholder
                textView.textColor = .gray400
            }
        } else if textView == purposeTextView {
            if textView.text.isEmpty {
                textView.text = purposePlaceholder
                textView.textColor = .gray400
            }
        }
        
        if targetTextView.text.isOnlyKorEngSpe() && resultTextView.text.isOnlyKorEngSpe() && differenceTextView.text.isOnlyKorEngSpe() && continuouslyTextView.text.isOnlyKorEngSpe() && purposeTextView.text.isOnlyKorEngSpe() {
            if targetTextView.text != targetPlaceholder && resultTextView.text != resultPlaceholder && differenceTextView.text != differencePlaceholder && continuouslyTextView.text != continuouslyPlaceholder && purposeTextView.text != purposePlaceholder {
                onCompletionAAR?(true)
            } else {
                onCompletionAAR?(false)
            }
        } else {
            onCompletionAAR?(false)
        }

    }
}

