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
    
    static func uploadHabitual(title: String, selectedTime: String,
                               completion: @escaping(FirestoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
//        ImageUploader.uploadImage(image: image) { imageUrl in
            let data = ["title": title,
                        "timestamp": Timestamp(date: Date()),
                        "selectedTime": selectedTime,
                        "OwnerUid": uid]
                        as [String : Any]
            
            COLLECTION_HABITUAL.addDocument(data: data, completion: completion)
//        }
    }
    
    static func fetchHabituals(completion: @escaping([Habitual]) -> Void) {
        COLLECTION_HABITUAL.order(by: "timestamp", descending: true).getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            
            let habitual = documents.map({ Habitual(habitualId: $0.documentID, dictionary: $0.data()) })
            completion(habitual)
        }
    }
    
    static func fetchHabituals(forUser uid: String, completion: @escaping([Habitual]) -> Void) {
        let query = COLLECTION_HABITUAL.whereField("ownerUid", isEqualTo: uid)
        
        query.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            
            let habitual = documents.map({ Habitual(habitualId: $0.documentID, dictionary: $0.data()) })
            completion(habitual)
        }
    }
}
