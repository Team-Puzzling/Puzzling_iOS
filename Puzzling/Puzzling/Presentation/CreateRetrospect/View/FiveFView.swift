//
//  FiveFView.swift
//  Puzzling
//
//  Created by 천성우 on 2023/07/13.
//

import UIKit

import Then
import SnapKit


class FiveFView: UIView {
        
    // MARK: - UI Components

    private let factLabel = UILabel()
    private let feelingLabel = UILabel()
    private let findingLabel = UILabel()
    private let futureLabel = UILabel()
    private let feedbackLabel = UILabel()
    
    private let factNumLabel = UILabel()
    private let feelingNumLabel = UILabel()
    private let findingNumLabel = UILabel()
    private let futureNumLabel = UILabel()
    private let feedbackNumLabel = UILabel()
    
    let factTextView = UITextView()
    let feelingTextView = UITextView()
    let findingTextView = UITextView()
    let futureTextView = UITextView()
    let feedbackTextView = UITextView()
    
    
    // MARK: - View Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setUI()
        
        factTextView.delegate = self
        feelingTextView.delegate = self
        findingTextView.delegate = self
        futureTextView.delegate = self
        feedbackTextView.delegate = self

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapScreen))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components Property
    
    private func setUI() {
        factLabel.do {
            $0.text = "Fact"
            $0.textColor = .black000
            $0.font = .fontGuide(.body1_bold_kor)
        }
        feelingLabel.do {
            $0.text = "Feeling"
            $0.textColor = .black000
            $0.font = .fontGuide(.body1_bold_kor)
        }
        
        findingLabel.do {
            $0.text = "Finding"
            $0.textColor = .black000
            $0.font = .fontGuide(.body1_bold_kor)
        }
        
        futureLabel.do {
            $0.text = "Future action"
            $0.textColor = .black000
            $0.font = .fontGuide(.body1_bold_kor)
        }
        
        feedbackLabel.do {
            $0.text = "Feedback"
            $0.textColor = .black000
            $0.font = .fontGuide(.body1_bold_kor)
        }
        
        factNumLabel.do {
            $0.text = "0/200"
            $0.textAlignment = .right
            $0.textColor = .gray400
            $0.font = .fontGuide(.detail3_regular_kor)
        }
        
        feelingNumLabel.do {
            $0.text = "0/200"
            $0.textAlignment = .right
            $0.textColor = .gray400
            $0.font = .fontGuide(.detail3_regular_kor)
        }
        
        findingNumLabel.do {
            $0.text = "0/200"
            $0.textAlignment = .right
            $0.textColor = .gray400
            $0.font = .fontGuide(.detail3_regular_kor)
        }
        
        futureNumLabel.do {
            $0.text = "0/200"
            $0.textAlignment = .right
            $0.textColor = .gray400
            $0.font = .fontGuide(.detail3_regular_kor)
        }
        
        feedbackNumLabel.do {
            $0.text = "0/200"
            $0.textAlignment = .right
            $0.textColor = .gray400
            $0.font = .fontGuide(.detail3_regular_kor)
        }
        
        factTextView.do {
            $0.text = "\"오늘 무슨 일이 있었는지\" 작성해 보세요"
            $0.textColor = .gray400
            $0.backgroundColor = UIColor.background050
            $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            $0.layer.cornerRadius = 16
            $0.font = .fontGuide(.body2_regular_kor)
        }
        
        feelingTextView.do {
            $0.text = "\"그 과정에서 무슨 느낌이 들었는지\" 작성해 보세요"
            $0.textColor = .gray400
            $0.backgroundColor = UIColor.background050
            $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            $0.layer.cornerRadius = 16
            $0.font = .fontGuide(.body2_regular_kor)
        }
        
        findingTextView.do {
            $0.text = "\"오늘 어떤 인사이트를 얻었는지\" 작성해 보세요"
            $0.textColor = .gray400
            $0.backgroundColor = UIColor.background050
            $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            $0.layer.cornerRadius = 16
            $0.font = .fontGuide(.body2_regular_kor)
        }
        
        futureTextView.do {
            $0.text = "\"앞으로 무엇을 해야 할지, 어떤 액션을 취해야 할지\" 작성해 보세요"
            $0.textColor = .gray400
            $0.backgroundColor = UIColor.background050
            $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            $0.layer.cornerRadius = 16
            $0.font = .fontGuide(.body2_regular_kor)
        }
        
        feedbackTextView.do {
            $0.text = "\"앞서 정한 향후 행동을 실천해본 뒤, 이에 대해 어떤 피드백을 받았는지\" 작성해 보세요"
            $0.textColor = .gray400
            $0.backgroundColor = UIColor.background050
            $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            $0.layer.cornerRadius = 16
            $0.font = .fontGuide(.body2_regular_kor)
        }
    }
    
    // MARK: - Layout Helper

    private func setLayout() {
        self.backgroundColor = .white000
        
        addSubviews(
            factLabel,
            feelingLabel,
            findingLabel,
            futureLabel,
            feedbackLabel,
            factTextView,
            feelingTextView,
            findingTextView,
            futureTextView,
            feedbackTextView,
            factNumLabel,
            feelingNumLabel,
            findingNumLabel,
            futureNumLabel,
            feedbackNumLabel
        )
        
        factLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        factTextView.snp.makeConstraints {
            $0.top.equalTo(factLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(118)
        }
        
        factNumLabel.snp.makeConstraints {
            $0.top.equalTo(factTextView.snp.bottom).inset(-4)
            $0.trailing.equalTo(factTextView.snp.trailing).inset(16)
        }
        
        feelingLabel.snp.makeConstraints {
            $0.top.equalTo(factTextView.snp.bottom).offset(45)
            $0.leading.equalToSuperview().offset(16)
        }
        
        feelingTextView.snp.makeConstraints {
            $0.top.equalTo(feelingLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(118)
        }
        
        feelingNumLabel.snp.makeConstraints {
            $0.top.equalTo(feelingTextView.snp.bottom).inset(-4)
            $0.trailing.equalTo(feelingTextView.snp.trailing).inset(16)
        }
        
        findingLabel.snp.makeConstraints {
            $0.top.equalTo(feelingTextView.snp.bottom).offset(45)
            $0.leading.equalToSuperview().offset(16)
        }
     
        findingTextView.snp.makeConstraints {
            $0.top.equalTo(findingLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(118)
        }
        
        findingNumLabel.snp.makeConstraints {
            $0.top.equalTo(findingTextView.snp.bottom).inset(-4)
            $0.trailing.equalTo(findingTextView.snp.trailing).inset(16)
        }
        
        futureLabel.snp.makeConstraints {
            $0.top.equalTo(findingTextView.snp.bottom).offset(45)
            $0.leading.equalToSuperview().offset(16)
        }
     
        futureTextView.snp.makeConstraints {
            $0.top.equalTo(futureLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(118)
        }
        
        futureNumLabel.snp.makeConstraints {
            $0.top.equalTo(futureTextView.snp.bottom).inset(-4)
            $0.trailing.equalTo(futureTextView.snp.trailing).inset(16)
        }
        
        feedbackLabel.snp.makeConstraints {
            $0.top.equalTo(futureTextView.snp.bottom).offset(45)
            $0.leading.equalToSuperview().offset(16)
        }
     
        feedbackTextView.snp.makeConstraints {
            $0.top.equalTo(feedbackLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(118)
        }
        
        feedbackNumLabel.snp.makeConstraints {
            $0.top.equalTo(feedbackTextView.snp.bottom).inset(-4)
            $0.trailing.equalTo(futureTextView.snp.trailing).inset(16)
        }

    }
    
    // MARK: - @objc Methods
    
    @objc private func didTapScreen() {
          self.endEditing(true)
    }
}

extension FiveFView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
           if textView == factTextView {
               let textCount = textView.text.count
               factNumLabel.text = "\(textCount)/200"
               if textCount > 200 {
                   textView.deleteBackward()
               }
           } else if textView == feelingTextView {
               let textCount = textView.text.count
               feelingNumLabel.text = "\(textCount)/200"
               if textCount > 200 {
                   textView.deleteBackward()
               }
           } else if textView == findingTextView {
               let textCount = textView.text.count
               findingNumLabel.text = "\(textCount)/200"
               if textCount > 200 {
                   textView.deleteBackward()
               }
           } else if textView == futureTextView {
               let textCount = textView.text.count
               futureNumLabel.text = "\(textCount)/200"
               if textCount > 200 {
                   textView.deleteBackward()
               }
           } else if textView == feedbackTextView {
               let textCount = textView.text.count
               feedbackNumLabel.text = "\(textCount)/200"
               if textCount > 200 {
                   textView.deleteBackward()
               }
           }


       }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        textView.layer.borderColor = UIColor.blue200.cgColor
        textView.layer.borderWidth = 2.0
        
        if textView == factTextView {
            if textView.textColor == .gray400 {
                textView.text = nil
                textView.textColor = .black000
                textView.font = .fontGuide(.body2_regular_kor)
            }
        } else if textView == feelingTextView {
            if textView.textColor == .gray400{
                textView.text = nil
                textView.textColor = .black000
                textView.font = .fontGuide(.body2_regular_kor)
            }
        }
        else if textView == findingTextView {
            if textView.textColor == .gray400 {
                textView.text = nil
                textView.textColor = .black000
                textView.font = .fontGuide(.body2_regular_kor)
            }
        }
        else if textView == futureTextView {
            if textView.textColor == .gray400 {
                textView.text = nil
                textView.textColor = .black000
                textView.font = .fontGuide(.body2_regular_kor)
            }
        }
        else if textView == feedbackTextView {
            if textView.textColor == .gray400 {
                textView.text = nil
                textView.textColor = .black000
                textView.font = .fontGuide(.body2_regular_kor)
            }
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        
        textView.layer.borderColor = UIColor.clear.cgColor
        textView.layer.borderWidth = 0.0
                
        if textView == factTextView {
            if textView.text.isEmpty {
                textView.text = "\"오늘 무슨 일이 있었는지\" 작성해 보세요"
                textView.textColor = .gray400
            }
        } else if textView == feelingTextView {
            if textView.text.isEmpty {
                textView.text = "\"그 과정에서 무슨 느낌이 들었는지\" 작성해 보세요"
                textView.textColor = .gray400
            }
        } else if textView == findingTextView {
            if textView.text.isEmpty {
                textView.text = "\"오늘 어떤 인사이트를 얻었는지\" 작성해 보세요"
                textView.textColor = .gray400
            }
        } else if textView == futureTextView {
            if textView.text.isEmpty {
                textView.text = "\"앞으로 무엇을 해야 할지, 어떤 액션을 취해야 할지\" 작성해 보세요"
                textView.textColor = .gray400
            }
        } else if textView == feedbackTextView {
            if textView.text.isEmpty {
                textView.text = "\"앞서 정한 향후 행동을 실천해본 뒤, 이에 대해 어떤 피드백을 받았는지\" 작성해 보세요"
                textView.textColor = .gray400
            }
        }
    }
}
