//
//  UserService.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/11.
//

import Firebase

typealias FirestoreCompletion = (Error?) -> Void

struct UserService {
    static func fetchUser(completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    
    static func fetchUsers(completion: @escaping([User]) -> Void) {
        COLLECTION_USERS.getDocuments { snapshot, error in
            guard let snapshot = snapshot else { return }
            
            let users = snapshot.documents.map({ User(dictionary: $0.data()) })
            completion(users)
        }
    }
    
    static func fetchUserStats(uid: String, completion: @escaping(UserStats) -> Void) {
        COLLECTION_HABITUAL.whereField("ownerUid", isEqualTo: uid).getDocuments { snapshot, _ in
            let habituals = snapshot?.documents.count ?? 0
            completion(UserStats(habituals: habituals))
        }
    }
}
