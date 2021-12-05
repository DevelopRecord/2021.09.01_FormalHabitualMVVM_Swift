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
    static func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    static func RegisterUser(withCredential credentials: AuthCredentials, completion: @escaping(Error?) -> Void) {
        
        ImageUploader.uploadImage(image: credentials.profileImage) { imageUrl in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
                if let error = error {
                    print("DEBUG: Failed to register user \(error.localizedDescription)")
                    return
                }
                
                guard let uid = result?.user.uid else { return }
                
                let data: [String: Any] = ["email": credentials.email,
                                           "fullname": credentials.fullname,
                                           "profileImageUrl": imageUrl,
                                           "uid": uid,
                                           "age": credentials.age]
                
                COLLECTION_USERS.document(uid).setData(data, completion: completion)
            }
        }
    }
    
    static func deleteUser(completion: @escaping(Error?) -> Void) {
        Auth.auth().currentUser?.delete(completion: { error in
            if let error = error {
                print("DEBUG: Failed to delete user.. \(error.localizedDescription)")
                return
            }
            
            guard let uid = Auth.auth().currentUser?.uid else { return }
            
            COLLECTION_USERS.document(uid).delete(completion: completion)
        })
    }
    
    static func resetPassword(withEmail email: String, completion: SendPasswordResetCallback?) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: completion)
    }
    
    static func changePassword(password: String, completion: UserUpdateCallback?) {
        Auth.auth().currentUser?.updatePassword(to: password, completion: completion)
    }
}
