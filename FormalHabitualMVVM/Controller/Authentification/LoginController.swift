//
//  LoginController.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/01.
//

import UIKit

class LoginController: UIViewController {
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        self.hideKeyboardWhenTappedAround()
        moveViewWithKeyboard()
        self.moveViewWithKeyboard()
    }
    
    //MARK: Properties
    private let habitualLabel: UILabel = {
        let label = UILabel()
        label.text = "Habitual"
        label.font = UIFont.systemFont(ofSize: 38, weight: UIFont.Weight.semibold)
        return label
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "로그인"
        label.setHeight(50)
        return label
    }()
    
    private let emailTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Email")
        tf.keyboardType = .emailAddress
        tf.setHeight(50)
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.setHeight(50)
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let loginButton: UIButton = {
        let button = CustomLoginButton()
        button.setTitle("LOGIN", for: UIControl.State.normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.addTarget(self, action: #selector(loginButtonTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Forgot your password?", secondPart: "Get help signing in.")
        button.addTarget(self, action: #selector(handleShowForgotButton), for: .touchUpInside)
        return button
    }()
    
    private let naverLoginButton: UIButton = {
        let button = CustomLoginButton()
        button.setTitle("NAVER로 로그인", for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.backgroundColor = UIColor(named: "naverColor")
        return button
    }()
    
    private let kakaoLoginButton: UIButton = {
        let button = CustomLoginButton()
        button.setTitle("KAKAO로 로그인", for: UIControl.State.normal)
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button.backgroundColor = UIColor(named: "kakaoColor")
        return button
    }()
    
    private let joinButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Don't have an account?", secondPart: "Sign Up.")
        button.addTarget(self, action: #selector(joinButtonTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    // MARK: Helpers
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(habitualLabel)
        habitualLabel.translatesAutoresizingMaskIntoConstraints = false
        habitualLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 180).isActive = true
        habitualLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton,  forgotPasswordButton, naverLoginButton, kakaoLoginButton])
        stack.axis = .vertical // StackView를 수평 혹은 수직으로 할지 설정합니다
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.centerX(inView: view)
        stack.anchor(top: habitualLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(joinButton)
        joinButton.centerX(inView: view)
        joinButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        
    }
    
    // MARK: Actions
    @objc func loginButtonTapped() {
        print("DEBUG: Log In Button did tap")
    }
    
    @objc func joinButtonTapped() {
         let RegistrationVC = RegistrationController()
         self.present(RegistrationVC, animated: true, completion: nil)
         print("DEBUG: Registration button tapped")
    }
    
    @objc func handleShowForgotButton() {
        print("DEBUG: Forgot button did tap")
    }
}

