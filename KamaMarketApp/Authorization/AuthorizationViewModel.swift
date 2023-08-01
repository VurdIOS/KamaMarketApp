//
//  AuthorizationViewModel.swift
//  KamaMarketApp
//
//  Created by Камаль Атавалиев on 01.08.2023.
//

import Foundation

protocol AuthorizationViewModelProtocol {
    var logoImage: String { get }
}

class AuthorizationViewModel: AuthorizationViewModelProtocol {
    var logoImage = "Logo"
}
