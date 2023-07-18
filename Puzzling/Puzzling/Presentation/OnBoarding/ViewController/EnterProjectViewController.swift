//
//  EnterProjectViewController.swift
//  Puzzling
//
//  Created by Minjoo Kim on 2023/07/19.
//

import UIKit

import Moya
import SnapKit
import Then

final class EnterProjectViewController: UIViewController {
    
    // MARK: - UI Components
    private let rootView = EnterProjectView()
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
