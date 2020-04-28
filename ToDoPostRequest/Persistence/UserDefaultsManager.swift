//
//  UserDefaultsManager.swift
//  ToDoPostRequest
//
//  Created by C4Q on 4/28/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import Foundation

fileprivate let userNameKey = "userName"

struct UserDefaultsManager {
    private init () {}
    
    static let shared = UserDefaultsManager()
    
    private let userDefaults = UserDefaults.standard
    
    
    func setUserName(userName: String) {
        userDefaults.set(userName, forKey: userNameKey)
    }
    
    func getUserName() -> String? {
        let userName = userDefaults.object(forKey: userNameKey) as? String
        return userName
    }
    
}
