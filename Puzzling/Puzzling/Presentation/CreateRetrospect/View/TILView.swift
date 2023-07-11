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
    
    // MARK: - Properties
    
    private let wellLabel = UILabel().then {
        $0.text = "잘한 점은 무엇인가요?"
        $0.textColor = .black000
        $0.font = .fontGuide(.body1_bold_kor)
    }
    
    private let regretLabel = UILabel().then {
        $0.text = "아쉬운 점은 무엇인가요"
        $0.textColor = .black000
        $0.font = .fontGuide(.body1_bold_kor)
    }
    
    private let learnLabel = UILabel().then {
        $0.text = "배운 점은 무엇인가요?"
        $0.textColor = .black000
        $0.font = .fontGuide(.body1_bold_kor)
    }
    
    private let wellNumLabel = UILabel().then{
        $0.text = "0/200"
        $0.textAlignment = .right
        $0.textColor = .gray400
        $0.font = .fontGuide(.detail3_regular_kor)
    }
    
    private let regretNumLabel = UILabel().then{
        $0.text = "0/200"
        $0.textAlignment = .right
        $0.textColor = .gray400
        $0.font = .fontGuide(.detail3_regular_kor)
    }
    
    private let learnNumLabel = UILabel().then{
        $0.text = "0/200"
        $0.textAlignment = .right
        $0.textColor = .gray400
        $0.font = .fontGuide(.detail3_regular_kor)
    }
    
    let wellTextView = UITextView().then {
        $0.text = "\"오늘의 나는 무엇을 잘했는지\" 작성해 보세요"
        $0.textColor = .gray400
        $0.backgroundColor = UIColor.background050
        $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        $0.layer.cornerRadius = 16
        $0.font = .fontGuide(.body2_regular_kor)    }
    
    let regretTextView = UITextView().then {
        $0.text = "\"어떤 문제/어려움을 겪었는지, 향후 어떤 액션으로 이를 해결해볼 것인지\" 작성해 보세요"
        $0.textColor = .gray400
        $0.backgroundColor = UIColor.background050
        $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        $0.layer.cornerRadius = 16
        $0.font = .fontGuide(.body2_regular_kor)
    }
    
    let learnTextView = UITextView().then {
        $0.text = "\"오늘은 일에서 어떤 것을 배웠는지\" 작성해 보세요"
        $0.textColor = .gray400
        $0.backgroundColor = UIColor.background050
        $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        $0.layer.cornerRadius = 16
        $0.font = .fontGuide(.body2_regular_kor)
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        wellTextView.delegate = self
        regretTextView.delegate = self
        learnTextView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    
    private func setLayout() {
        self.backgroundColor = .white000
        
        addSubviews(
            wellLabel,
            regretLabel,
            learnLabel,
            wellTextView,
            regretTextView,
            learnTextView,
            wellNumLabel,
            regretNumLabel,
            learnNumLabel
        )
        
        wellLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        wellTextView.snp.makeConstraints {
            $0.top.equalTo(wellLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(118)
        }
        
        wellNumLabel.snp.makeConstraints {
            $0.bottom.equalTo(wellTextView.snp.bottom).inset(16)
            $0.trailing.equalTo(wellTextView.snp.trailing).inset(16)
        }
        
        regretLabel.snp.makeConstraints {
            $0.top.equalTo(wellTextView.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(16)
        }
        
        regretTextView.snp.makeConstraints {
            $0.top.equalTo(regretLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(118)
        }
        
        regretNumLabel.snp.makeConstraints {
            $0.bottom.equalTo(regretTextView.snp.bottom).inset(16)
            $0.trailing.equalTo(regretTextView.snp.trailing).inset(16)
        }
        
        learnLabel.snp.makeConstraints {
            $0.top.equalTo(regretTextView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        learnTextView.snp.makeConstraints {
            $0.top.equalTo(learnLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(118)
            $0.bottom.equalToSuperview().offset(-16)
        }
        
        learnNumLabel.snp.makeConstraints {
            $0.bottom.equalTo(learnTextView.snp.bottom).inset(16)
            $0.trailing.equalTo(learnTextView.snp.trailing).inset(16)
        }
    }
}

extension TILView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
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
                
        if textView == wellTextView {
            if textView.text.isEmpty {
                textView.text = "\"오늘의 나는 무엇을 잘했는지\"작성해 보세요"
                textView.textColor = .gray400
            }
        } else if textView == regretTextView {
            if textView.text.isEmpty {
                textView.text = "\"어떤 문제/어려움을 겪었는지, 향후 어떤 액션으로 이를 해결해볼 것인지\"작성해 보세요"
                textView.textColor = .gray400
            }
        } else if textView == learnTextView {
            if textView.text.isEmpty {
                textView.text = "\"오늘은 일에서 어떤 것을 배웠는지\"작성해 보세요"
                textView.textColor = .gray400
            }
        }
    }
}