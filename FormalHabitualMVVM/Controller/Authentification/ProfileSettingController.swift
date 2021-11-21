//
//  ProfileSettingController.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/10.
//

import UIKit
import Firebase

class ProfileSettingController: UIViewController {
    
    // MARK: Properties
    
    var viewModel: ProfileHeaderViewModel? {
        didSet { configure() }
    }
    
    private let emailTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Email")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("저장하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleSaveButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        navigationItem.title = "계정설정"
        navigationController?.navigationBar.tintColor = .black
//        let backButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(handleBackButton))
//
//        navigationItem.leftBarButtonItem = backButton
        
    }
    
    // MARK: Actions
    
    @objc func handleSaveButton() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(emailTextField)
        emailTextField.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingRight: 10)
        emailTextField.centerX(inView: view)
        
        view.addSubview(passwordTextField)
        passwordTextField.anchor(top: emailTextField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingRight: 10)
        passwordTextField.centerX(inView: view)
        
        view.addSubview(saveButton)
        saveButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
        saveButton.setDimensions(height: 55, width: view.frame.width)
    }
    
    func configure() {
        guard let viewModel = viewModel else { return }
        
    }
}
