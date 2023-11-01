//
//  RegistrationViewModel.swift
//  KamaMarketApp
//
//  Created by Камаль Атавалиев on 01.11.2023.
//

import Foundation

protocol RegistrationViewModelProtocol {
    var userName: String { get set }
    var userEmail: String { get set }
}

class RegistrationViewModel: RegistrationViewModelProtocol {
    var userName: String {
        get {
            "111"
        }
        set {
            
        }
    }
    
    var userEmail: String {
        get {
            "111"
        }
        set {
            
        }
    }
    
}
