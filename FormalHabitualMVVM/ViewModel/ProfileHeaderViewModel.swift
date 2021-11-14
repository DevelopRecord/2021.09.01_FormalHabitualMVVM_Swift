//
//  ProfileHeaderViewModel.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/12.
//

import Foundation

struct ProfileHeaderViewModel {
    let user: User
    
    var fullname: String {
        return user.fullname
    }
    
    var profileImageUrl: URL? { return URL(string: user.profileImageUrl) }
    
    init(user: User) {
        self.user = user
    }
}
