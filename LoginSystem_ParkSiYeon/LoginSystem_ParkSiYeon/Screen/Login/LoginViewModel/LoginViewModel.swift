//
//  LoginViewModel.swift
//  LoginSystem_ParkSiYeon
//
//  Created by siyeon park on 3/15/25.
//

import Foundation
import RxSwift

final class LoginViewModel {
    // 상태 전달을 위한 Observable
    let logoutSuccess = PublishSubject<Void>()
    let withdrawSuccess = PublishSubject<Void>()
    let nickname = BehaviorSubject<String>(value: "")
    
    private let userDefaultsManager = UserDefaultsManager.shared
    private let coreDataManager = UserInfoCoreDataManager.shared
    
    init() {
        if let savedNickname = userDefaultsManager.getNickname() {
            nickname.onNext(savedNickname) // 사용자 이름을 BehaviorSubject에 전달
        }
    }
    
    // 로그인 성공 처리
    func loginSuccess() {
        userDefaultsManager.saveUserLoggedIn(true)  // 로그인 상태 저장
    }
    
    func logout() {
        userDefaultsManager.clearUserLoggedIn()
        userDefaultsManager.clearNickname()
        userDefaultsManager.clearUserEmail()
        
        logoutSuccess.onNext(())
    }
    
    func withdraw() {
        guard let email = userDefaultsManager.getUserEmail() else {
            return
        }
        
        let coreDataManager = UserInfoCoreDataManager.shared
        if let user = coreDataManager.fetchUserByEmail(email: email) {
            coreDataManager.deleteUser(user: user)
            
            userDefaultsManager.clearUserLoggedIn()
            userDefaultsManager.clearNickname()
            userDefaultsManager.clearUserEmail()
            
            withdrawSuccess.onNext(())
        }
    }
}
