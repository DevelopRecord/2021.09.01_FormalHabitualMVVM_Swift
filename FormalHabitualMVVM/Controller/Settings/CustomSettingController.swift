//
//  CustomSettingController.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/12/20.
//

import UIKit
import SnapKit

class CustomSettingController: UIViewController {
    
    // MARK: Properties
    
    private let previousButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "delete.backward"), for: .normal)
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        return button
    }()
    
    private let pageLabel: UILabel = {
        let label = UILabel()
        label.text = "Custom Settings"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .systemGroupedBackground
        return label
    }()
    
    private let darkModeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("다크모드", for: .normal)
        return button
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        self.navigationItem.title = "Custom Settings"
    }
    
    // MARK: Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
//        previousButton.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
//            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(16)
//        }
    }
    
    // MARK: Actions
    
    @objc func handleDismissal() {
        navigationController?.popViewController(animated: true)
    }
}
