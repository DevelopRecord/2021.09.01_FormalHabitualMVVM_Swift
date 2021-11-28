//
//  LoginController.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/01.
//

import UIKit

protocol AuthentificationDelegate: AnyObject {
    func authentificationDidComplete()
}

protocol UserDeleteDelegate: AnyObject {
    func userDeleteDidComplete()
}

class LoginController: UIViewController {
    
    //MARK: Properties
    
    private var viewModel = LoginViewModel()
    weak var delegate: AuthentificationDelegate?
    weak var delegates: UserDeleteDelegate?
    
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
        button.setTitle("LOGIN", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.5)
        button.layer.cornerRadius = 10
        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).withAlphaComponent(0.5), for: .normal)
        button.isEnabled = false
        button.setHeight(50)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Forgot your password?", secondPart: "Get help signing in.")
        button.addTarget(self, action: #selector(handleShowResetPassword), for: .touchUpInside)
        return button
    }()
    
    private let kakaoLoginButtons: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "kakao_login"), for: .normal)
        return button
    }()
    
    private let naverLoginButton: UIButton = {
        let button = CustomLoginButton()
        button.setTitle("NAVER로 로그인", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(named: "naverColor")
        return button
    }()
    
    private let kakaoLoginButton: UIButton = {
        let button = CustomLoginButton()
        button.setTitle("KAKAO로 로그인", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor(named: "kakaoColor")
        return button
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Don't have an account?", secondPart: "Sign Up.")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        self.hideKeyboardWhenTappedAround()
        moveViewWithKeyboard()
        self.moveViewWithKeyboard()
        configureNotificationObserver()
    }
    
    // MARK: Actions
    
    @objc func handleLogin() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        AuthService.logUserIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG: Failed to log user in \(error.localizedDescription)")
                return
            }
            self.delegate?.authentificationDidComplete()
        }
    }
    
    @objc func handleShowSignUp() {
        let controller = RegistrationController()
        controller.delegate = delegate
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleShowResetPassword() {
        let controller = ResetPasswordController()
        controller.delegate = self
        controller.email = emailTextField.text
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        updateForm()
    }
    
    // MARK: Helpers
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(habitualLabel)
        habitualLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 75)
        habitualLabel.centerX(inView: view)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton,  forgotPasswordButton, naverLoginButton, kakaoLoginButton])
        stack.axis = .vertical // StackView를 수평 혹은 수직으로 할지 설정합니다
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.centerX(inView: view)
        stack.anchor(top: habitualLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    func configureNotificationObserver() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    
}

// MARK: FormViewModel

extension LoginController: FormViewModel {
    func updateForm() {
        loginButton.backgroundColor = viewModel.buttonBackgroundColor
        loginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        loginButton.isEnabled = viewModel.formValid
    }
}

// MARK: ResetPasswordControllerDelegate

extension LoginController: ResetPasswordControllerDelegate {
    func controllerDidSendPasswordResetLink(_ controller: ResetPasswordController) {
        navigationController?.popViewController(animated: true)
        showMessage(withTitle: "Success", message: "회원님의 이메일로 링크를 보냈습니다. 확인해 주세요.")
    }
}

// MARK: ProfileControllerDelegates

extension LoginController: ProfileControllerDelegates {
    func controllerDeletedUser() {
        let controller = LoginController()
        controller.delegate = self.tabBarController as? MainTabController
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
        showMessage(withTitle: "Success", message: "회원탈퇴가 완료되었습니다.")
        
    }
}
