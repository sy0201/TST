//
//  MockUserDefaultsManager.swift
//  StartViewModelTests
//
//  Created by siyeon park on 3/16/25.
//

import XCTest

protocol UserDefaultsManagerProtocol {
    func getUserLoggedIn() -> Bool
    func saveUserLoggedIn(_ value: Bool)
    func saveNickname(_ nickname: String)
    func saveUserEmail(_ email: String)
}

class MockUserDefaultsManager: UserDefaultsManagerProtocol {
    var loggedIn = false
    var nickname = ""
    var email = ""
    
    func getUserLoggedIn() -> Bool {
        return loggedIn
    }
    
    func saveUserLoggedIn(_ value: Bool) {
        loggedIn = value
    }
    
    func saveNickname(_ value: String) {
        nickname = value
    }
    
    func saveUserEmail(_ value: String) {
        email = value
    }
}
