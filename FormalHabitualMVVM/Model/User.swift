//
//  User.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/11.
//

import Foundation

struct User {
    let email: String
    let fullname: String
    let profileImageUrl: String
    let age: String
    let uid: String
    
    init(dictionary: [String: Any]) {
        self.email = dictionary["email"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.age = dictionary["age"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
