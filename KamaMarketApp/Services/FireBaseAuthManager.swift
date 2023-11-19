//
//  FireBaseManager.swift
//  KamaMarketApp
//
//  Created by Камаль Атавалиев on 12.11.2023.
//

import Foundation
import Firebase


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

