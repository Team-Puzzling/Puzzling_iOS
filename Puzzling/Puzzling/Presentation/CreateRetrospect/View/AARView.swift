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
    
    
    // MARK: - View Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setUI()
        
        targetTextView.delegate = self
        resultTextView.delegate = self
        differenceTextView.delegate = self
        continuouslyTextView.delegate = self
        purposeTextView.delegate = self

        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapScreen))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components Property
    
    private func setUI() {
        targetLabel.do {
            $0.text = "초기 목표"
            $0.textColor = .black000
            $0.font = .fontGuide(.body1_bold_kor)
        }
        resultLabel.do {
            $0.text = "결과"
            $0.textColor = .black000
            $0.font = .fontGuide(.body1_bold_kor)
        }
        
        differenceLabel.do {
            $0.text = "차이"
            $0.textColor = .black000
            $0.font = .fontGuide(.body1_bold_kor)
        }
        
        continuouslyLabel.do {
            $0.text = "지속"
            $0.textColor = .black000
            $0.font = .fontGuide(.body1_bold_kor)
        }
        
        purposeLabel.do {
            $0.text = "목적"
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
            $0.text = "\"업무 전에 의도한 혹은 얻고자 한 결과는 무엇이었는지\" 작성해 보세요"
            $0.textColor = .gray400
            $0.backgroundColor = UIColor.background050
            $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            $0.layer.cornerRadius = 16
            $0.font = .fontGuide(.body2_regular_kor)
        }
        
        resultTextView.do {
            $0.text = "\"실제로 오늘 하루 어떤 일이 있었는지\" 작성해 보세요"
            $0.textColor = .gray400
            $0.backgroundColor = UIColor.background050
            $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            $0.layer.cornerRadius = 16
            $0.font = .fontGuide(.body2_regular_kor)
        }
        
        differenceTextView.do {
            $0.text = "\"목표와 실제 결과 사이의 차이는 왜 발생했을지\" 작성해 보세요"
            $0.textColor = .gray400
            $0.backgroundColor = UIColor.background050
            $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            $0.layer.cornerRadius = 16
            $0.font = .fontGuide(.body2_regular_kor)
        }
        
        continuouslyTextView.do {
            $0.text = "\"지속하고 싶은 부분은 무엇인지\" 작성해 보세요"
            $0.textColor = .gray400
            $0.backgroundColor = UIColor.background050
            $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            $0.layer.cornerRadius = 16
            $0.font = .fontGuide(.body2_regular_kor)
        }
        
        purposeTextView.do {
            $0.text = "\"개선하거나 포기해야 할 부분은 무엇인지\" 작성해 보세요"
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
            targetLabel,
            resultLabel,
            differenceLabel,
            continuouslyLabel,
            purposeLabel,
            targetTextView,
            resultTextView,
            differenceTextView,
            continuouslyTextView,
            purposeTextView,
            targetNumLabel,
            resultNumLabel,
            differenceNumLabel,
            continuouslyNumLabel,
            purposeNumLabel
        )
        
        targetLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
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
            $0.leading.equalToSuperview().offset(16)
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
            $0.leading.equalToSuperview().offset(16)
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
            $0.leading.equalToSuperview().offset(16)
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
            $0.leading.equalToSuperview().offset(16)
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

    }
    
    // MARK: - @objc Methods
    
    @objc private func didTapScreen() {
          self.endEditing(true)
    }
}

extension AARView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
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
        
        textView.layer.borderColor = UIColor.blue200.cgColor
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
        
        textView.layer.borderColor = UIColor.clear.cgColor
        textView.layer.borderWidth = 0.0
                
        if textView == targetTextView {
            if textView.text.isEmpty {
                textView.text = "\"업무 전에 의도한 혹은 얻고자 한 결과는 무엇이었는지\" 작성해 보세요"
                textView.textColor = .gray400
            }
        } else if textView == resultTextView {
            if textView.text.isEmpty {
                textView.text = "\"실제로 오늘 하루 어떤 일이 있었는지\" 작성해 보세요"
                textView.textColor = .gray400
            }
        } else if textView == differenceTextView {
            if textView.text.isEmpty {
                textView.text = "\"목표와 실제 결과 사이의 차이는 왜 발생했을지\" 작성해 보세요"
                textView.textColor = .gray400
            }
        } else if textView == continuouslyTextView {
            if textView.text.isEmpty {
                textView.text = "\"지속하고 싶은 부분은 무엇인지\" 작성해 보세요"
                textView.textColor = .gray400
            }
        } else if textView == purposeTextView {
            if textView.text.isEmpty {
                textView.text = "\"개선하거나 포기해야 할 부분은 무엇인지\" 작성해 보세요"
                textView.textColor = .gray400
            }
        }
    }
}
