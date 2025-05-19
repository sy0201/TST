//
//  UserDefaultsManagerTests.swift
//  LoginSystem_ParkSiYeonTests
//
//  Created by siyeon park on 3/16/25.
//

import XCTest

class UserDefaultsManagerTests: XCTestCase {
    var userDefaultsManager: MockUserDefaultsManager!

    override func setUp() {
        userDefaultsManager = MockUserDefaultsManager()
    }

    func testSaveAndGetLoginStatus() {
        userDefaultsManager.saveUserLoggedIn(true)
        XCTAssertTrue(userDefaultsManager.getUserLoggedIn())
    }
}
