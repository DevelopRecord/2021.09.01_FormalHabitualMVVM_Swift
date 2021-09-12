//
//  ProfileSettingController.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/10.
//

import UIKit

class ProfileSettingController: UIViewController {
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        let backButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(handleBackButton))
        
        navigationItem.leftBarButtonItem = backButton
        
    }
    
    // MARK: Actions
    
    @objc func handleBackButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        
    }
    
}
