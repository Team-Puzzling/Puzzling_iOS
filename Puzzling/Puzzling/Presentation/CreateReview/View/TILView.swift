//
//  TILView.swift
//  Puzzling
//
//  Created by 천성우 on 2023/07/10.
//

import UIKit

import Then
import SnapKit

class TILView: UIView {
        
    // MARK: - UI Components
    
    private let wellLabel = UILabel()
    private let regretLabel = UILabel()
    private let learnLabel = UILabel()
    
    private let wellNumLabel = UILabel()
    private let regretNumLabel = UILabel()
    private let learnNumLabel = UILabel()
    
    let wellTextView = UITextView()
    let regretTextView = UITextView()
    let learnTextView = UITextView()
    
    private let errorWellLabel = UILabel()
    private let errorRegertLabel = UILabel()
    private let errorLearnLabel = UILabel()
    
    
    // MARK: - Properties
    
    private let wellPlaceholder: String = "\"오늘의 나는 무엇을 잘했는지\" 작성해 보세요"
    private let regretPlaceholder: String = "\"어떤 문제/어려움을 겪었는지, 향후 어떤 액션으로 이를 해결해볼 것인지\" 작성해 보세요"
    private let learnPlaceholder: String = "\"오늘은 일에서 어떤 것을 배웠는지\" 작성해 보세요"
    
    var onCompletionTIL: ((Bool) -> Void)?
    
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

extension TILView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        self.backgroundColor = .white000
        
        wellLabel.do {
            $0.text = "잘한 점은 무엇인가요?"
            $0.textColor = .black000
            $0.font = .fontGuide(.body1_bold_kor)
        }
        
        regretLabel.do {
            $0.text = "아쉬운 점은 무엇인가요"
            $0.textColor = .black000
            $0.font = .fontGuide(.body1_bold_kor)
        }
        
        learnLabel.do {
            $0.text = "배운 점은 무엇인가요?"
            $0.textColor = .black000
            $0.font = .fontGuide(.body1_bold_kor)
        }
        
        wellNumLabel.do {
            $0.text = "0/200"
            $0.textAlignment = .right
            $0.textColor = .gray400
            $0.font = .fontGuide(.detail3_regular_kor)
        }
        
        regretNumLabel.do {
            $0.text = "0/200"
            $0.textAlignment = .right
            $0.textColor = .gray400
            $0.font = .fontGuide(.detail3_regular_kor)
        }
        
        learnNumLabel.do {
            $0.text = "0/200"
            $0.textAlignment = .right
            $0.textColor = .gray400
            $0.font = .fontGuide(.detail3_regular_kor)
        }
        
        wellTextView.do {
            $0.text = wellPlaceholder
            $0.textColor = .gray400
            $0.backgroundColor = UIColor.background050
            $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            $0.layer.cornerRadius = 16
            $0.font = .fontGuide(.body2_regular_kor)
        }
        
        regretTextView.do {
            $0.text = regretPlaceholder
            $0.textColor = .gray400
            $0.backgroundColor = UIColor.background050
            $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            $0.layer.cornerRadius = 16
            $0.font = .fontGuide(.body2_regular_kor)
        }
        
        learnTextView.do {
            $0.text = learnPlaceholder
            $0.textColor = .gray400
            $0.backgroundColor = UIColor.background050
            $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            $0.layer.cornerRadius = 16
            $0.font = .fontGuide(.body2_regular_kor)
        }
        
        errorWellLabel.do {
            $0.text = "이모지를 사용할 수 없어요."
            $0.textColor = .red400
            $0.font = .fontGuide(.detail1_regular_kor)
            $0.isHidden = true
        }
        
        errorRegertLabel.do {
            $0.text = "이모지를 사용할 수 없어요."
            $0.textColor = .red400
            $0.font = .fontGuide(.detail1_regular_kor)
            $0.isHidden = true
        }
        
        errorLearnLabel.do {
            $0.text = "이모지를 사용할 수 없어요."
            $0.textColor = .red400
            $0.font = .fontGuide(.detail1_regular_kor)
            $0.isHidden = true
        }
        
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        addSubviews( wellLabel, regretLabel, learnLabel,
                     wellTextView, regretTextView, learnTextView,
                     wellNumLabel, regretNumLabel, learnNumLabel,
                     errorWellLabel, errorRegertLabel, errorLearnLabel)
        
        wellLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(24)
            $0.height.equalTo(24)
        }
        
        wellTextView.snp.makeConstraints {
            $0.top.equalTo(wellLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(118)
        }
        
        wellNumLabel.snp.makeConstraints {
            $0.top.equalTo(wellTextView.snp.bottom).inset(-4)
            $0.trailing.equalTo(wellTextView.snp.trailing).inset(16)
        }
        
        regretLabel.snp.makeConstraints {
            $0.top.equalTo(wellTextView.snp.bottom).offset(45)
            $0.leading.equalToSuperview().offset(24)
            $0.height.equalTo(24)
        }
        
        regretTextView.snp.makeConstraints {
            $0.top.equalTo(regretLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(118)
        }
        
        regretNumLabel.snp.makeConstraints {
            $0.top.equalTo(regretTextView.snp.bottom).inset(-4)
            $0.trailing.equalTo(regretTextView.snp.trailing).inset(16)
        }
        
        learnLabel.snp.makeConstraints {
            $0.top.equalTo(regretTextView.snp.bottom).offset(45)
            $0.leading.equalToSuperview().offset(24)
            $0.height.equalTo(24)
        }
        
        learnTextView.snp.makeConstraints {
            $0.top.equalTo(learnLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(118)
        }
        
        learnNumLabel.snp.makeConstraints {
            $0.top.equalTo(learnTextView.snp.bottom).inset(-4)
            $0.trailing.equalTo(learnTextView.snp.trailing).inset(16)
        }
        
        errorWellLabel.snp.makeConstraints {
            $0.top.equalTo(wellTextView.snp.bottom).inset(-4)
            $0.leading.equalToSuperview().inset(24)
        }
        
        errorRegertLabel.snp.makeConstraints {
            $0.top.equalTo(regretTextView.snp.bottom).inset(-4)
            $0.leading.equalToSuperview().inset(24)
        }
        
        errorLearnLabel.snp.makeConstraints {
            $0.top.equalTo(learnTextView.snp.bottom).inset(-4)
            $0.leading.equalToSuperview().inset(24)
        }
    }
    
    // MARK: - Methods
    
    private func setDelegate() {
        wellTextView.delegate = self
        regretTextView.delegate = self
        learnTextView.delegate = self
    }
    
    private func setErrorHidden(for textView: UITextView, isHidden: Bool) {
        switch textView {
        case wellTextView:
            errorWellLabel.isHidden = isHidden
        case regretTextView:
            errorRegertLabel.isHidden = isHidden
        case learnTextView:
            errorLearnLabel.isHidden = isHidden
        default:
            break
        }
    }
}

extension TILView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == wellTextView || textView == regretTextView || textView == learnTextView {
            let isValid = textView.text.isOnlyKorEngSpe()
            if isValid {
                textView.layer.borderColor = UIColor.blue200.cgColor
                setErrorHidden(for: textView, isHidden: true)
            } else {
                textView.layer.borderColor = UIColor.red200.cgColor
                setErrorHidden(for: textView, isHidden: false)
                onCompletionTIL?(false)
            }
        }
        
        if textView == wellTextView {
            let textCount = textView.text.count
            wellNumLabel.text = "\(textCount)/200"
            if textCount > 200 {
                textView.deleteBackward()
            }
        } else if textView == regretTextView {
            let textCount = textView.text.count
            regretNumLabel.text = "\(textCount)/200"
            if textCount > 200 {
                textView.deleteBackward()
            }
        } else if textView == learnTextView {
            let textCount = textView.text.count
            learnNumLabel.text = "\(textCount)/200"
            if textCount > 200 {
                textView.deleteBackward()
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView == wellTextView || textView == regretTextView || textView == learnTextView {
            let isValid = textView.text.isOnlyKorEngSpe()
            if isValid {
                textView.layer.borderColor = UIColor.blue200.cgColor
                setErrorHidden(for: textView, isHidden: true)
            } else {
                textView.layer.borderColor = UIColor.red200.cgColor
                setErrorHidden(for: textView, isHidden: false)
                onCompletionTIL?(false)
            }
        }
        textView.layer.borderWidth = 2.0
        
        if textView == wellTextView {
            if textView.textColor == .gray400 {
                textView.text = nil
                textView.textColor = .black000
                textView.font = .fontGuide(.body2_regular_kor)
            }
        } else if textView == regretTextView {
            if textView.textColor == .gray400{
                textView.text = nil
                textView.textColor = .black000
                textView.font = .fontGuide(.body2_regular_kor)
            }
        }
        else if textView == learnTextView {
            if textView.textColor == .gray400 {
                textView.text = nil
                textView.textColor = .black000
                textView.font = .fontGuide(.body2_regular_kor)
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView == wellTextView || textView == regretTextView || textView == learnTextView {
            let isValid = textView.text.isOnlyKorEngSpe()
            if isValid {
                textView.layer.borderColor = UIColor.clear.cgColor
                setErrorHidden(for: textView, isHidden: true)
                textView.layer.borderWidth = 0.0
                
            } else {
                textView.layer.borderColor = UIColor.red200.cgColor
                textView.layer.borderWidth = 2.0
                setErrorHidden(for: textView, isHidden: false)
                onCompletionTIL?(false)
            }
        }
        
        if textView == wellTextView {
            if textView.text.isEmpty {
                textView.text = wellPlaceholder
                textView.textColor = .gray400
            }
        } else if textView == regretTextView {
            if textView.text.isEmpty {
                textView.text = regretPlaceholder
                textView.textColor = .gray400
            }
        } else if textView == learnTextView {
            if textView.text.isEmpty {
                textView.text = learnPlaceholder
                textView.textColor = .gray400
            }
        }
        
        if wellTextView.text.isOnlyKorEngSpe() && regretTextView.text.isOnlyKorEngSpe() && learnTextView.text.isOnlyKorEngSpe() {
            if wellTextView.text != wellPlaceholder && regretTextView.text != regretPlaceholder && learnTextView.text != learnPlaceholder {
                onCompletionTIL?(true)
            } else {
                onCompletionTIL?(false)
            }
        } else {
            onCompletionTIL?(false)
        }
    }
}
