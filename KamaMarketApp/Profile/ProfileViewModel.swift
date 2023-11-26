//
//  ProfileViewModel.swift
//  KamaMarketApp
//
//  Created by Камаль Атавалиев on 25.11.2023.
//

import Foundation

protocol ProfileViewModelProtocol {
    var userName: String? { get }
}

class ProfileViewModel: ProfileViewModelProtocol {
    var userName: String?
    
    
}
