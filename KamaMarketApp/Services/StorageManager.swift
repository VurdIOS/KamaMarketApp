//
//  StorageManager.swift
//  KamaMarketApp
//
//  Created by Камаль Атавалиев on 01.11.2023.
//

import Foundation

final class StorageManager {
    
    static let shared = StorageManager()
    
    private let userDefaults = UserDefaults.standard
    private let keyForUsers = "MarketUsers"
    
    private init() {}
    
    
    func save(user: User) {
        var users = fetchUsers()
        users.append(user)
        guard let data = try? JSONEncoder().encode(users) else { return }
        userDefaults.set(data, forKey: keyForUsers)
    }
    
    func fetchUsers() -> [User] {
        guard let data = userDefaults.data(forKey: keyForUsers) else { return [] }
        guard let users = try? JSONDecoder().decode([User].self, from: data) else { return [] }
        return users
    }
}
