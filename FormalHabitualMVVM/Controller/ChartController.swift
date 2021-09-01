//
//  ChartController.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/01.
//

import UIKit

class ChartController: UIViewController {
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: Helper
    func configureUI() {
        view.backgroundColor = .systemBlue
        
        navigationController?.navigationBar.isHidden = true
    }
}
