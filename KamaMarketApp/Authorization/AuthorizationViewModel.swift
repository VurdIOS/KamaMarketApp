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
        if name == "Kama", password == "33" {
            return true
        } else {
            return false
        }
        
    }
    

}
