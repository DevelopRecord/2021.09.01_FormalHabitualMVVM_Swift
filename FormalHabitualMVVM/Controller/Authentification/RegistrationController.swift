//
//  RegistrationController.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/01.
//

import UIKit

class RegistrationController: UIViewController {
    
    // MARK: Properties
    
    private var viewModel = RegistrationViewModel()
    private var profileImage: UIImage?
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo-1"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(handleProfilePhotoSelect), for: .touchUpInside)
        return button
    }()
    
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
    
    private let confirmPasswordTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Confirm password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let fullnameTextField: UITextField = {
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
    
    private let SignUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.5)
        button.layer.cornerRadius = 10
        button.isEnabled = false
        button.setHeight(50)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
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
        let button = UIButton(type: .system)
        button.setTitle("NAVER로 회원가입", for: .normal)
        button.layer.cornerRadius = 10
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.backgroundColor = UIColor(named: "naverColor")
        button.setHeight(50)
        return button
    }()
    
    private let kakaoJoinButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("KAKAO로 회원가입", for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor(named: "kakaoColor")
        button.setHeight(50)
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
    @objc func handleSignUp() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let confirmPassword = confirmPasswordTextField.text else { return }
        guard let fullname = fullnameTextField.text else { return }
        guard let age = ageTextField.text else { return }
        guard let profileImage = self.profileImage else { return }
        
        let credentials = AuthCredentials(email: email, password: password, confirmPassword: confirmPassword, fullname: fullname, age: age, profileImage: profileImage)
        
        AuthService.RegisterUser(withCredential: credentials) { error in
            if let error = error {
                print("Failed to register user \(error.localizedDescription)")
                return
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else if sender == passwordTextField {
            viewModel.password = sender.text
        } else if sender == confirmPasswordTextField {
            viewModel.confirmPassword = sender.text
        } else if sender == fullnameTextField {
            viewModel.fullname = sender.text
        } else {
            viewModel.age = sender.text
        }
        updateForm()
    }
    
    @objc func handleProfilePhotoSelect() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    // MARK: Helper
    func configureUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view)
        plusPhotoButton.setDimensions(height: 120, width: 120)
        plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, confirmPasswordTextField, fullnameTextField, ageTextField, infoLabel, SignUpButton, orLabel, naverJoinButton, kakaoJoinButton])
        stack.axis = .vertical // StackView를 수평 혹은 수직으로 할지 설정합니다
        stack.spacing = 16
        stack.setHeight(660)
        
        view.addSubview(stack)
        stack.centerX(inView: view)
        stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 6, paddingLeft: 32, paddingRight: 32)
    }
    
    func configureNotificationObserver() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        confirmPasswordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        ageTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
}

extension RegistrationController: FormViewModel {
    func updateForm() {
        SignUpButton.backgroundColor = viewModel.buttonBackgroundColor
        SignUpButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        SignUpButton.isEnabled = viewModel.formValid
    }
}

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        profileImage = selectedImage
        
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.black.cgColor
        plusPhotoButton.layer.borderWidth = 2
        plusPhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.dismiss(animated: true, completion: nil)
    }
}
