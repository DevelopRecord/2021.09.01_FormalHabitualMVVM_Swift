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
        let button = UIButton(type: .system)
        button.setTitle("LOGIN", for: UIControl.State.normal)
        button.layer.cornerRadius = 10
        button.setHeight(50)
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
        let button = UIButton(type: .custom)
        button.setTitle("NAVER로 로그인", for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(named: "naverColor")
        button.setHeight(50)
        return button
    }()
    
    private let kakaoLoginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("KAKAO로 로그인", for: UIControl.State.normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(named: "kakaoColor")
        button.setHeight(50)
        return button
    }()
    
    private let joinButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Don't have an account?", secondPart: "Sign Up.")
        button.addTarget(self, action: #selector(joinButtonTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    
    
    // MARK: Helper
    func configureColors() {
        if self.traitCollection.userInterfaceStyle == .dark { //유저 인터페이스가 다크 테마일 때
            loginButton.backgroundColor = .white
            loginButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        } else { //일반 라이트 모드일 때
            loginButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
            loginButton.backgroundColor = .black
        }
    }
    
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
        stack.anchor(top: habitualLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
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
    
    // MARK: Override
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        // 디바이스의 테마가 변경될 때 마다 이 함수가 발동되어집니다
        configureColors()
    }
}

