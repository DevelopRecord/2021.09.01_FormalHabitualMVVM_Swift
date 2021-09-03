//
//  RegistrationController.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/01.
//

import UIKit

class RegistrationController: UIViewController {
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        self.hideKeyboardWhenTappedAround()
        moveViewWithKeyboard()
        self.moveViewWithKeyboard()
    }
    
    // MARK: Properties
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
        label.font = UIFont.systemFont(ofSize: 38, weight: UIFont.Weight.semibold)
        return label
    }()
    
    private let idTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Email")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let pwTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let pwConfirmTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Confirm password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let nameTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Fullname")
        return tf
    }()
    
    private let ageTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Age")
        tf.keyboardType = .numberPad
        return tf
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "회원가입 시 이용약관과 개인정보 취급방침에\n 동의한 것으로 간주됩니다. 해당정보는 습관 생성에\n 도움을 주는 용도로만 사용됩니다."
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.thin)
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("REGISTER", for: UIControl.State.normal)
        button.layer.cornerRadius = 10
        button.setHeight(50)
        button.addTarget(self, action: #selector(registerButtonTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    private let orLabel: UILabel = {
        let label = UILabel()
        label.text = "또는"
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.thin)
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    private let naverJoinButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("NAVER로 회원가입", for: UIControl.State.normal)
        button.layer.cornerRadius = 10
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.backgroundColor = UIColor(named: "naverColor")
        button.setHeight(50)
        return button
    }()
    
    private let kakaoJoinButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("KAKAO로 회원가입", for: UIControl.State.normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button.backgroundColor = UIColor(named: "kakaoColor")
        button.setHeight(50)
        return button
    }()
    
    // MARK: Helper
    func configureUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(signUpLabel)
        signUpLabel.centerX(inView: view)
        signUpLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stack = UIStackView(arrangedSubviews: [idTextField, pwTextField, pwConfirmTextField, nameTextField, ageTextField, infoLabel, registerButton, orLabel, naverJoinButton, kakaoJoinButton])
        stack.axis = .vertical // StackView를 수평 혹은 수직으로 할지 설정합니다
        stack.spacing = 20
        stack.setHeight(660)
        
        view.addSubview(stack)
        stack.centerX(inView: view)
        stack.anchor(top: signUpLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
    }
    
    // MARK: Actions
    @objc func registerButtonTapped() {
        print("DEBUG: Registration Button did tap")
    }
    
    // MARK: Configures
    func configureColors() {
        if self.traitCollection.userInterfaceStyle == .dark { // 유저 인터페이스가 다크 테마일 때
            registerButton.backgroundColor = .white
            registerButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        } else { // 일반 라이트 모드일 때
            registerButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
            registerButton.backgroundColor = .black
        }
    }
    
    // MARK: Override
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        // 디바이스의 테마가 변경될 때 마다 이 함수가 발동되어집니다
        configureColors()
    }
}
