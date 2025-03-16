//
//  MockCoreDataManager.swift
//  LoginSystem_ParkSiYeonTests
//
//  Created by siyeon park on 3/16/25.
//

import XCTest

// CoreDataManagerProtocol.swift
protocol CoreDataManagerProtocol {
    func isEmailAlreadyExists(email: String) -> Bool
    func saveUserInfo(email: String, password: String, nickname: String) throws
}

class MockCoreDataManager: CoreDataManagerProtocol {
    var storedEmails: [String] = []
    var shouldThrowOnSave = false

    func isEmailAlreadyExists(email: String) -> Bool {
        return storedEmails.contains(email)
    }

    func saveUserInfo(email: String, password: String, nickname: String) throws {
        if shouldThrowOnSave {
            throw NSError(domain: "MockCoreDataError", code: 1, userInfo: nil)
        }
        storedEmails.append(email)
    }
}
