//
//  CoreDataManagerTests.swift
//  LoginSystem_ParkSiYeonTests
//
//  Created by siyeon park on 3/16/25.
//

import XCTestCase

class CoreDataManagerTests: XCTestCase {
    var coreDataManager: MockCoreDataManager!
    
    override func setUp() {
        coreDataManager = MockCoreDataManager()
    }
    
    func testSaveUserInfo() throws {
        try coreDataManager.saveUserInfo(email: "test@example.com", password: "password", nickname: "nickname")
        XCTAssertTrue(coreDataManager.isEmailAlreadyExists(email: "test@example.com"))
    }
    
    func testSaveUserInfoWithError() {
        coreDataManager.shouldThrowOnSave = true
        XCTAssertThrowsError(try coreDataManager.saveUserInfo(email: "test@example.com", password: "password", nickname: "nickname"))
    }
}
