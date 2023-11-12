//
//  AuthorizationViewModel.swift
//  KamaMarketApp
//
//  Created by Камаль Атавалиев on 01.08.2023.
//

import Foundation

protocol AuthorizationViewModelProtocol {
    
    var userEmail: String? { get set }
    var password: String? { get set}
    
    var logoImage: String { get }
    
    func singIn(complition: @escaping(Result<Any, Error>) -> Void)
}

class AuthorizationViewModel: AuthorizationViewModelProtocol {
    
    var userEmail: String?

    var password: String?

    var logoImage = "Logo"

    func singIn(complition: @escaping(Result<Any, Error>) -> Void) {
        guard let userEmail = userEmail else { return }
        guard let password = password else { return }
        FireBaseManager.shared.signIn(withEmail: userEmail, password: password) { Result in
            switch Result {
            case .success(_):
                complition(.success("Good"))
            case .failure(let error):
                complition(.failure(error))
            }
        }
    }
}
