//
//  HabitualService.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/10/01.
//

// Habituals - title, timestamp, dayOfTheWeek, time, alertMusic, ownUid

import UIKit
import Firebase

struct HabitualService {
    
    static func uploadHabitual(title: String, completion: @escaping(FirestoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
//        ImageUploader.uploadImage(image: image) { imageUrl in
            let data = ["title": title,
                        "timestamp": Timestamp(date: Date()),
                        
                        "OwnerUid": uid]
                        as [String : Any]
            
            COLLECTION_HABITUAL.addDocument(data: data, completion: completion)
//        }
    }
}
