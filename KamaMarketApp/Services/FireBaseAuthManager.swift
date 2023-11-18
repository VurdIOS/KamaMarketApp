//
//  FireBaseManager.swift
//  KamaMarketApp
//
//  Created by Камаль Атавалиев on 12.11.2023.
//

enum UserAction: String {
    case like = "likes"
    case Buy = "inCart"
}

import Foundation
import Firebase
import FirebaseDatabase

class FireBaseAuthManager {
    
    static let shared = FireBaseAuthManager()
    
    private init () {}
    
    func createUser(withEmail: String, password: String, completion: @escaping(Result<Any, Error>) -> Void) {
        Auth.auth().createUser(withEmail: withEmail, password: password) { firebaseResult, error in
            switch error {
            case .none:
                completion(.success(""))
            case .some(let error):
                completion(.failure(error))
            }
        }
    }
    func signIn(withEmail: String, password: String, completion: @escaping(Result<Any, Error>) -> Void) {
        Auth.auth().signIn(withEmail: withEmail, password: password) { firebaseResult, error in
            switch error {
            case .none:
                completion(.success(""))
            case .some(let error):
                completion(.failure(error))
            }
        }
    }
    
}

class FireBaseDataManager {
    
    static let shared = FireBaseDataManager()
    
    private init() {}
    
    private lazy var databasePath: DatabaseReference? = {
        // 1
        guard let uid = Auth.auth().currentUser?.uid else {
            return nil
        }
        // 2
        let ref = Database.database()
            .reference()
            .child("users/\(uid)/likes")
        return ref
    }()
    
    // 3
    private let encoder = JSONEncoder()
    
    func likeTapped(staffID: [String]) {
        // 1
        guard let databasePath = databasePath else {
            return
        }
        
        do {
            // 4
            let data = try encoder.encode(staffID)
            
            // 5
            let json = try JSONSerialization.jsonObject(with: data)
            
            // 6
            databasePath.childByAutoId()
                .setValue(json)
        } catch {
            print("pidaraz", error)
        }
    }
}

