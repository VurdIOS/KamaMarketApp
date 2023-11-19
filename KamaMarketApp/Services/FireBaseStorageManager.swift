//
//  FireBaseStorageManager.swift
//  KamaMarketApp
//
//  Created by Камаль Атавалиев on 19.11.2023.
//
enum UserAction: String {
    case like = "likes"
    case inCart = "inCart"
}

import Foundation
import Firebase
import FirebaseDatabase

class FireBaseDataManager {
    
    static let shared = FireBaseDataManager()
    
    private init() {}
    
    
    lazy var databaseLikePath: DatabaseReference? = {
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
    
    lazy var databaseInCartPath: DatabaseReference? = {
        // 1
        guard let uid = Auth.auth().currentUser?.uid else {
            return nil
        }
        // 2
        let ref = Database.database()
            .reference()
            .child("users/\(uid)/inCart")
        return ref
    }()
    
    var inCart: [inCartModel] = []
    // 3
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    func likeTapped(staffID: [String]) {
        // 1
        guard let databasePath = databaseLikePath else {
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
            print("PIDARAZ", error)
        }
    }
    
    func inCartTapped(staffID: String) {
        // 1
        guard let databasePath = databaseInCartPath else {
            return
        }
        
        let staff = inCartModel(text: staffID)
        
        do {
            // 4
            let data = try encoder.encode(staff)
            
            // 5
            let json = try JSONSerialization.jsonObject(with: data)
            
            // 6
            databasePath.childByAutoId()
                .setValue(json)
        } catch {
            print("PIDARAZ", error)
        }
    }

    func inCartListen(complition: @escaping((inCartModel) -> Void)) {
        // 1
        guard let databasePath = databaseInCartPath else {
          return
        }

        // 2
        
        databasePath.observe(.childAdded) { [weak self] snapshot,_ in
            print(snapshot.value)
            guard
              let self = self,
              var json = snapshot.value as? [String: Any]
            else {
              return
            }

            // 4
            json["id"] = snapshot.key

            do {

              // 5
              let cartData = try JSONSerialization.data(withJSONObject: json)
              // 6
                let cart = try self.decoder.decode(inCartModel.self, from: cartData)
              // 7
                complition(cart)
            } catch {
              print("1111111111111111111111111 an error occurred", error)
            }
        }
    }
    
}

