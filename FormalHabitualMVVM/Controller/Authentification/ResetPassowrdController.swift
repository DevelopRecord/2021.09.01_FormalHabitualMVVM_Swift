//
//  ResetPassowrdController.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/11/12.
//

import UIKit
import SnapKit

protocol ResetPasswordControllerDelegate: AnyObject {
    func controllerDidSendPasswordResetLink(_ controller: ResetPasswordController)
}

class ResetPasswordController: UIViewController {
    
    // MARK: Properties
    
    private let emailTextField = CustomTextField(placeholder: "Email")
    private var viewModel = ResetPasswordViewModel()
    weak var delegate: ResetPasswordControllerDelegate?
    var email: String?
    
    private let habitualLabel: UILabel = {
        let label = UILabel()
        label.text = "Habitual"
        label.font = UIFont.systemFont(ofSize: 38, weight: UIFont.Weight.semibold)
        return label
    }()
    
    private let resetPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset Password", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.5)
        button.layer.cornerRadius = 10
        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).withAlphaComponent(0.5), for: .normal)
        button.isEnabled = false
        button.setHeight(50)
        button.addTarget(self, action: #selector(handleResetPassword), for: .touchUpInside)
        return button
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        return button
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: Actions
    
    @objc func handleResetPassword() {
        guard let email = emailTextField.text else { return }
        
        self.showLoader(true)
        AuthService.resetPassword(withEmail: email) { error in
            if let error = error {
                self.showMessage(withTitle: "Error", message: error.localizedDescription)
                self.showLoader(false)
                return
            }
            
            self.delegate?.controllerDidSendPasswordResetLink(self)
        }
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        }
        updateForm()
    }
    
    @objc func handleDismissal() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: Helpers

    func configureUI() {
        view.backgroundColor = .white
        
        emailTextField.text = email
        viewModel.email = email
        updateForm()
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.left.equalTo(view.snp.left).offset(16)
        }
        
        view.addSubview(habitualLabel)
        habitualLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(75)
            make.centerX.equalTo(view)
        }
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, resetPasswordButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalTo(habitualLabel.snp.bottom).offset(32)
            make.left.equalTo(view.snp.left).offset(32)
            make.right.equalTo(view.snp.right).offset(-32)
            make.centerX.equalTo(view)
        }
    }
}

// MARK: FormViewModel

extension ResetPasswordController: FormViewModel {
    func updateForm() {
        resetPasswordButton.backgroundColor = viewModel.buttonBackgroundColor
        resetPasswordButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        resetPasswordButton.isEnabled = viewModel.formValid
    }
}
