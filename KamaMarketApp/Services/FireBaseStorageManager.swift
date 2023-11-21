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
            .child("users/\(uid)likes")
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
    
    lazy var databaseUserInfoPath: DatabaseReference? = {
        // 1
        guard let uid = Auth.auth().currentUser?.uid else {
            return nil
        }
        // 2
        let ref = Database.database()
            .reference()
            .child("users/\(uid)")
        return ref
    }()
    
    // 3
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    //Этой хуйней можно запкодипровать и отправить на сервер
    func returee(something: UserInfo) -> Any {
        var dfsdf: Any = ""
        do {
            // 4
            let data = try encoder.encode(something)
            
            // 5
            let json = try JSONSerialization.jsonObject(with: data)
            return json

        } catch {
            print("PIDARAZ", error)
        }
        return dfsdf
    }
    
    func sendUserInfoToFireBase(user: UserInfo) {
        // 1
        guard let databasePath = databaseUserInfoPath else {
            return
        }
        
        
        do {
            // 4
            let data = try encoder.encode(user)
            
            // 5
            let json = try JSONSerialization.jsonObject(with: data)
            
            // 6
            databasePath.childByAutoId()
                .setValue(json)
        } catch {
            print("PIDARAZ", error)
        }
    }
    
    func likeTapped(staffID: String) {
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
    
    func inCartTapped(staffID: inCartModel) {
        // 1
        guard let databasePath = databaseInCartPath else {
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
    
    func inCartListen(complition: @escaping((Result<inCartModel, Error>) -> Void)) {
        guard let databasePath = databaseInCartPath else {
            return
        }
        
        // 2
        
        databasePath.observe(.childAdded) { [weak self] snapshot,_ in

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
                let cart = try self.decoder.decode(inCartModel.self, from: cartData)
                complition(.success(cart))
                print(cart)
            
            } catch {
                complition(.failure(error))
            }
        }
    }
    
}

