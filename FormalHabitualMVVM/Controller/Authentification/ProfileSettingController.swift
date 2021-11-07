//
//  ProfileSettingController.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/10.
//

import UIKit

class ProfileSettingController: UIViewController {
    
    // MARK: Properties
    
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
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        let backButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(handleBackButton))
        let doneButton = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(handleDoneButton))
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = doneButton
        
    }
    
    // MARK: Actions
    
    @objc func handleBackButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleDoneButton() {
        print("DEBUG: Handle Done button..")
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
    }
    
}
