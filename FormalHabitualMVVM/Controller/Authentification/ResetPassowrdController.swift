//
//  ResetPassowrdController.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/11/12.
//

import UIKit

class ResetPasswordController: UIViewController {
    
    // MARK: Properties
    
    private let emailTextField = CustomTextField(placeholder: "Email")
    
    private var viewModel = ResetPasswordViewModel()
    
    private let habitualLabel: UILabel = {
        let label = UILabel()
        label.text = "Habitual"
        label.font = UIFont.systemFont(ofSize: 38, weight: UIFont.Weight.semibold)
        return label
    }()

    
    private let resetPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset Password", for: UIControl.State.normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.5)
        button.layer.cornerRadius = 10
        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).withAlphaComponent(0.5), for: .normal)
        button.isEnabled = false
        button.setHeight(50)
        button.addTarget(self, action: #selector(handleResetPassword), for: UIControl.Event.touchUpInside)
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
        
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 16, paddingLeft: 16)
        
        view.addSubview(habitualLabel)
        habitualLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 75)
        habitualLabel.centerX(inView: view)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, resetPasswordButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.centerX(inView: view)
        stack.anchor(top: habitualLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
    }
}

extension ResetPasswordController: FormViewModel {
    func updateForm() {
        resetPasswordButton.backgroundColor = viewModel.buttonBackgroundColor
        resetPasswordButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        resetPasswordButton.isEnabled = viewModel.formValid
    }
}
