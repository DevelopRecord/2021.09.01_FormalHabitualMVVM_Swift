//
//  LoginController.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/01.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import SDWebImage
import SnapKit

protocol AuthentificationDelegate: AnyObject {
    func authentificationDidComplete()
}

protocol UserDeleteDelegate: AnyObject {
    func userDeleteDidComplete()
}

protocol userInfoDelegate: AnyObject {
    func setUserInfo()
}

class LoginController: UIViewController {
    
    //MARK: Properties
    
    private var viewModel = LoginViewModel()
    weak var delegate: AuthentificationDelegate?
    weak var delegates: UserDeleteDelegate?
    
    private let habitualLabel: UILabel = {
        let label = UILabel()
        label.text = "Habitual"
        label.textColor = UIColor(named: "labelColor")
        label.font = UIFont.systemFont(ofSize: 38, weight: UIFont.Weight.semibold)
        return label
    }()
    
    private let emailTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Email")
        tf.backgroundColor = UIColor(named: "UIViewBackgroundColor")
        tf.keyboardType = .emailAddress
        tf.setHeight(50)
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.backgroundColor = UIColor(named: "UIViewBackgroundColor")
        tf.isSecureTextEntry = true
        tf.setHeight(50)
        return tf
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("LOGIN", for: .normal)
        button.setTitleColor(UIColor(named: "ButtonTitleColor")?.withAlphaComponent(0.4), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
//        button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.5)
        button.backgroundColor = UIColor(named: "ButtonBackgroundColor")?.withAlphaComponent(0.4)
        button.layer.cornerRadius = 10
//        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0,
//                                           alpha: 1.0).withAlphaComponent(0.5), for: .normal)
        button.isEnabled = false
        button.setHeight(50)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.textColor = UIColor(named: "labelColor")
        button.attributedTitle(firstPart: "Forgot your password?", secondPart: "Get help signing in.")
        button.addTarget(self, action: #selector(handleShowResetPassword), for: .touchUpInside)
        return button
    }()
    
    private let naverLoginButton: UIButton = {
        let button = CustomLoginButton()
        button.setTitle("NAVER로 로그인", for: .normal)
        button.setTitleColor(UIColor(named: "ButtonTitleColor"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = UIColor(named: "naverColor")
        return button
    }()
    
    private let kakaoLoginButton: UIButton = {
        let button = CustomLoginButton()
        button.setTitle("KAKAO로 로그인", for: .normal)
        button.setTitleColor(UIColor(named: "ButtonTitleColor"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = UIColor(named: "kakaoColor")
        button.addTarget(self, action: #selector(handleKakaoLogin), for: .touchUpInside)
        return button
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.textColor = UIColor(named: "labelColor")
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
    
    // MARK: API
    
    func setUserInfo() {
        UserApi.shared.me() { user, error in
            if let error = error {
                print(error)
            } else {
                print("me() success.")
                
                // 닉네임, 프로필사진
                let nickname = user?.kakaoAccount?.profile?.nickname
                let profileImage = user?.kakaoAccount?.profile?.profileImageUrl
                
                // 사용자 정보 넘기기
                let controller = SettingController()
                controller.profileButton.setTitle(nickname, for: .normal)
                controller.profileImageView.sd_setImage(with: profileImage)
                
            }
        }
    }
    
    // MARK: Actions
    
    @objc func handleKakaoLogin(_ sender: Any) {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in // 기기에 카카오톡이 설치되어 있지 않아도 웹으로 작동
           if let error = error {
               print(error)
           } else {
            print("loginWithKakaoAccount() success.")
           //do something
           _ = oauthToken
           // 어세스토큰
           let accessToken = oauthToken?.accessToken
           
           //카카오 로그인을 통해 사용자 토큰을 발급 받은 후 사용자 관리 API 호출
               
           self.setUserInfo()
//           self.delegate?.authentificationDidComplete()
            
            //do something
            _ = oauthToken
           }
        }
        /*
         //기기에 카카오톡이 설치되어 있을 때 작동
        // 카카오톡 설치 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")

                    // do something
                    _ = oauthToken
                    // 액세스 토큰
                    let accessToken = oauthToken?.accessToken
                }
            }
        }*/
    }
    
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
        view.backgroundColor = UIColor(named: "backgroundColor")
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(habitualLabel)
        habitualLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(75)
            make.centerX.equalTo(view)
        }
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton,  forgotPasswordButton, naverLoginButton, kakaoLoginButton])
        stack.axis = .vertical // StackView를 수평 혹은 수직으로 할지 설정합니다
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalTo(habitualLabel.snp.bottom).offset(32)
            make.left.equalTo(view.snp.left).offset(32)
            make.right.equalTo(view.snp.right).offset(-32)
            make.centerX.equalTo(view)
        }
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.centerX.equalTo(view)
        }
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
