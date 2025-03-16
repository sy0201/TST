//
//  UserDefaultsManager.swift
//  LoginSystem_ParkSiYeon
//
//  Created by siyeon park on 3/15/25.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let userDefaults = UserDefaults.standard
    
    private init() {}
    
    // 이름 충돌 방지 및 재사용성 증가
    private enum Keys {
        static let userLoggedIn = "userLoggedIn"
        static let nickname = "nickname"
        static let userEmail = "userEmail"
    }
}

// MARK: - Save UserDefaults

extension UserDefaultsManager {
    func saveUserLoggedIn(_ loggedIn: Bool) {
        userDefaults.set(loggedIn, forKey: Keys.userLoggedIn)
    }
    
    func saveNickname(_ nickname: String) {
        userDefaults.set(nickname, forKey: Keys.nickname)
    }
    
    func saveUserEmail(_ email: String) {
        userDefaults.set(email, forKey: Keys.userEmail)
    }
}

// MARK: - Fetch UserDefaults

extension UserDefaultsManager {
    func getUserLoggedIn() -> Bool {
        return userDefaults.bool(forKey: Keys.userLoggedIn)
    }
    
    func getNickname() -> String? {
        return userDefaults.string(forKey: Keys.nickname)
    }
    
    func getUserEmail() -> String? {
        return userDefaults.string(forKey: Keys.userEmail)
    }
}

// MARK: - Clear UserDefaults

extension UserDefaultsManager {
    func clearUserLoggedIn() {
        userDefaults.removeObject(forKey: Keys.userLoggedIn)
    }
    
    func clearNickname() {
        userDefaults.removeObject(forKey: Keys.nickname)
    }
    
    func clearUserEmail() {
        userDefaults.removeObject(forKey: Keys.userEmail)
    }
}
