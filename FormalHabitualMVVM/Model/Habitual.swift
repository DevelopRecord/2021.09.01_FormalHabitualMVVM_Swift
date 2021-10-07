//
//  Post.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/10/07.
//

import Firebase

struct Habitual {
    var title: String
    var selectedTime: String
    let ownerUid: String
    let timestamp: Timestamp
    let habitualId: String
    
    init(habitualId: String, dictionary: [String: Any]) {
        self.habitualId = habitualId
        self.title = dictionary["title"] as? String ?? ""
        self.selectedTime = dictionary["selectedTime"] as? String ?? ""
        self.ownerUid = dictionary["ownerUid"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
    }
}
