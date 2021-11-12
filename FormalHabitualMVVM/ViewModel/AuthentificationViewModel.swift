//
//  AuthentificationViewModel.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/04.
//

import UIKit

protocol FormViewModel {
    func updateForm()
}

protocol AuthentificationViewModel {
    var formValid: Bool { get }
    var buttonBackgroundColor: UIColor { get }
    var buttonTitleColor: UIColor { get }
}

struct LoginViewModel: AuthentificationViewModel {
    var email: String?
    var password: String?
    
    var formValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return formValid ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.5)
    }
    
    var buttonTitleColor: UIColor {
        return formValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
    
}

struct RegistrationViewModel: AuthentificationViewModel {
    var email: String?
    var password: String?
    var confirmPassword: String?
    var fullname: String?
    var age: String?
    
    var formValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false &&
               confirmPassword?.isEmpty == false && fullname?.isEmpty == false &&
            age?.isEmpty == false && password == confirmPassword
    }
    
    var buttonBackgroundColor: UIColor {
        return formValid ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.5)
    }
    
    var buttonTitleColor: UIColor {
        return formValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
}

struct ResetPasswordViewModel: AuthentificationViewModel {
    var email: String?
    
    var formValid: Bool { return email?.isEmpty == false }
    
    var buttonBackgroundColor: UIColor { return formValid ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.5) }
    
    var buttonTitleColor: UIColor { return formValid ? .white : UIColor(white: 1, alpha: 0.67) }
}
