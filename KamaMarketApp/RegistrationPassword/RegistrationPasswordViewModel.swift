//
//  RegistrationPasswordViewModel.swift
//  KamaMarketApp
//
//  Created by Камаль Атавалиев on 01.11.2023.
//

import Foundation

protocol RegistrationPasswordViewModelProtocol {
    var password: String { get set }
    
    var userName: String { get }
    
    var userEmail: String { get }
    
    
    init(userName: String, userEmail: String)
}

class RegistrationPasswordViewModel: RegistrationPasswordViewModelProtocol {
    
    var password: String {
        get {
            ""
        } set {
            StorageManager.shared.save(user: User(name: userName,
                                                  email: userEmail,
                                                  password: newValue))
        }
    }
    
    var userName: String
    
    var userEmail: String
    
    required init(userName: String, userEmail: String) {
        self.userName = userName
        self.userEmail = userEmail
    }
    
    
}
