//
//  AuthentificationViewModel.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/04.
//

import UIKit

struct LoginViewModel {
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

struct RegistrationViewModel {
    
}
