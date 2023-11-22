//
//  FireBaseStorageManager.swift
//  KamaMarketApp
//
//  Created by Камаль Атавалиев on 19.11.2023.
//
enum UserAction: String {
    case like = "likes"
    case inCart = "inCart"
    case userInfo = "userInfo"
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
            .child("users/\(uid)")
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
            .child("users/\(uid)/")
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

    
    func convert(toJSON: Codable) -> Any? {
        do {
            // 4
            let data = try encoder.encode(toJSON)
            
            // 5
            let json = try JSONSerialization.jsonObject(with: data)
            return json

        } catch {
            print("PIDARAZ", error)
        }
        return nil
    }
    
    func sendUserInfoToFireBase(user: UserInfo) {
        let user = convert(toJSON: user)
        databaseUserInfoPath?.child("userInfo").setValue(user)
    }


    func likeTapped(staffID: String) {
//Пока не реализовано, нужно будет запрашивать рефрешить список и снова отправлять
    }
    //Не получается пока реализовать запрос козины дополнить и отправить его назад
    func getCartInfo() -> [String]{
        var new: [String] = []
        inCartListen { result in
            switch result {
            case .success(let model):
                new = model.text
            case.failure(let error):
                print(error)
            }
        }
        return new
    }
    //Не получается пока реализовать запрос козины дополнить и отправить его назад
    func inCartTapped(staffID: inCartModel) {
        let new = getCartInfo()
        let newnew = new + staffID.text
        
        let itemInCart = convert(toJSON: newnew)
        databaseInCartPath?.child(UserAction.inCart.rawValue).setValue(itemInCart)
 
    }
    
    func userInfoListen(complition: @escaping((Result<UserInfo, Error>) -> Void)) {
        guard let databasePath = databaseUserInfoPath?.child(UserAction.userInfo.rawValue) else {
            return
        }
        
        // 2
        
        databasePath.observe(.value) { [weak self] snapshot,_ in

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
                let userData = try JSONSerialization.data(withJSONObject: json)
                let user = try self.decoder.decode(UserInfo.self, from: userData)
                complition(.success(user))
                print(user)
            
            } catch {
                complition(.failure(error))
            }
        }
    }

    
    
    func inCartListen(complition: @escaping((Result<inCartModel, Error>) -> Void)) {
        guard let databasePath = databaseInCartPath?.child(UserAction.inCart.rawValue) else {
            return
        }
        
        // 2
        
        databasePath.observe(.value) { [weak self] snapshot,_ in

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

