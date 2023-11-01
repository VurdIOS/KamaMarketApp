//
//  AuthorizationViewModel.swift
//  KamaMarketApp
//
//  Created by Камаль Атавалиев on 01.08.2023.
//

import Foundation

protocol AuthorizationViewModelProtocol {
    var logoImage: String { get }
    
    func logInWith(name: String, password: String) -> Bool

}

class AuthorizationViewModel: AuthorizationViewModelProtocol {
    var logoImage = "Logo"
    
    
    func logInWith(name: String, password: String) -> Bool {
        let users = StorageManager.shared.fetchUsers()
        for user in users {
            print(user.name)
            print(user.password)
            if user.name == name, user.password == password {
                return true
            }
        }
        return false
    }
}
