//
//  CustomTextField.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/01.
//

import UIKit

class CustomTextField: UITextField {
    
    // MARK: Lifecycle
    
    init(placeholder: String) {
        super.init(frame: .zero)
        
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        leftView = spacer
        leftViewMode = .always
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.cornerRadius = 10
        textColor = .black
        keyboardAppearance = .dark
        keyboardType = .emailAddress
        backgroundColor = .white
        setHeight(50)
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor(white: 0.4, alpha: 0.7)])
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChange),
                                               name: UITextField.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleTextDidChange() {
        
    }
}

