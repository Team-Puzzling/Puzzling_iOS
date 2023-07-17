//
//  testViewController.swift
//  Puzzling
//
//  Created by 천성우 on 2023/07/13.
//

import UIKit

import Moya
import Then
import SnapKit

class testViewController: UIViewController {
    
    private let pushButton = UIButton()
    
    let previousTemplateProvider = MoyaProvider<CreateRetrospectService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    private var previousTemplateId: PreviousTemplateModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUI()
        setLayout()
        setDelegate()
    }
    
    private func setUI() {
        view.backgroundColor = .systemIndigo
        
        view.addSubview(pushButton)
        
        pushButton.do {
            $0.setTitle("규보심의 뷰에서 나오는 버튼~", for: .normal)
            $0.addTarget(self,
                        action: #selector(pushButtonTapped),
                        for: .touchUpInside)
        }
        pushButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func setLayout() {
        
    }
    
    private func setDelegate() {
        
    }
    
    func pushToCreateRetrospectViewController(option: String) {
        let VC = CreateRetrospectViewController(option: option)
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    func fetchPreviousTemplate() {
        previousTemplateProvider.request(.previousTemplate(memberID: "1", projectID: "1")) { result in
            switch result {
            case .success(let result):
                let status = result.statusCode
                if status >= 200 && status < 300 {
                    do {
                        guard let data = try? JSONDecoder().decode(PreviousTemplateResponce.self, from: result.data) else { return }
                        let test = data
                        print(test)
                    }
                    catch (let error) {
                        print("ㅋㅋㅋ 에러 ㅋ ㅋㅋ ㅋ ㅋ ㅋ")
                    }
                }
                else if status >= 400 {
                    print("400 이상 에러 ㅋ ㅋ ㅋ ㅋ ㅋ ㅋ ㅋ")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @objc
    func pushButtonTapped() {
        let option = "5F"
        pushToCreateRetrospectViewController(option: option)
        fetchPreviousTemplate()
    }
}
