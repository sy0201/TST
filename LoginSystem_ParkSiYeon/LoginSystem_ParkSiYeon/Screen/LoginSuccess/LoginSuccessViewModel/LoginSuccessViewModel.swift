//
//  LoginSuccessViewModel.swift
//  LoginSystem_ParkSiYeon
//
//  Created by siyeon park on 3/15/25.
//

import Foundation
import RxSwift

final class LoginSuccessViewModel {
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
    func login(email: String, password: String) {
        // 이메일로 해당 사용자가 존재하는지 확인
        if let user = coreDataManager.fetchUserByEmail(email: email) {
            // Keychain에서 비밀번호를 가져옴
            if let savedPassword = KeyChainHelper.getPassword(for: email) {
                // 비밀번호 비교
                if savedPassword == password {
                    // 비밀번호가 일치하면 로그인 성공 처리
                    userDefaultsManager.saveUserLoggedIn(true)
                    userDefaultsManager.saveNickname(user.nickname ?? "")
                    userDefaultsManager.saveUserEmail(user.email ?? "")
                } else {
                    // 비밀번호가 일치하지 않으면 실패 처리
                    print("비밀번호가 일치하지 않습니다.")
                }
            }
        } else {
            // 이메일이 존재하지 않으면 처리
            print("이메일을 찾을 수 없습니다.")
        }
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
