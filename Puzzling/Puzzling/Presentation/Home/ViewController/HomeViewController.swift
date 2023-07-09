//
//  ViewController.swift
//  Puzzling-iOS
//
//  Created by KJ on 2023/07/04.
//

import UIKit

class HomeViewController: UIViewController {

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "내 이름은 권정임"
        label.font = .fontGuide(.heading1_kor)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setLayout()
    }
}

private extension HomeViewController {
    
    func setStyle() {
        
        view.backgroundColor = .white
    }
    
    func setLayout() {
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
                                     nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50)])
    }


}

