//
//  AuthService.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/06.
//

import UIKit
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let confirmPassword: String
    let fullname: String
    let age: String
    let profileImage: UIImage
}

struct AuthService {
    static func RegisterUser(withCredential credentials: AuthCredentials) {
        
    }
}
