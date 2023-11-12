//
//  RegistrationPasswordViewModel.swift
//  KamaMarketApp
//
//  Created by Камаль Атавалиев on 01.11.2023.
//

import Foundation

protocol RegistrationPasswordViewModelProtocol {
    var password: String? { get set }
    
    var userName: String { get }
    
    var userEmail: String { get }
    
    func createNewUser(complition: @escaping(Result<Any, Error>) -> Void)
    
    
    init(userName: String, userEmail: String)
}

class RegistrationPasswordViewModel: RegistrationPasswordViewModelProtocol {
    
    var password: String?
    
    func createNewUser(complition: @escaping(Result<Any, Error>) -> Void) {
        guard let password = password else { return }
        FireBaseManager.shared.createUser(withEmail: userEmail, password: password) { Result in
            switch Result {
            case .success(_):
                complition(.success("Good"))
            case .failure(let error):
                complition(.failure(error))
            }
        }
    }
        
    var userName: String
    
    var userEmail: String
    
    required init(userName: String, userEmail: String) {
        self.userName = userName
        self.userEmail = userEmail
    }
    
    
}
