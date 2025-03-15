//
//  SignUpViewModel.swift
//  LoginSystem_ParkSiYeon
//
//  Created by siyeon park on 3/15/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SignUpViewModel {
    let email = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    let confirmPassword = BehaviorRelay<String>(value: "")
    let nickname = BehaviorRelay<String>(value: "")
    
    let emailValid: Observable<Bool>
    let passwordValid: Observable<Bool>
    let confirmPasswordValid: Observable<Bool>
    let nicknameValid: Observable<Bool>
    
    let signUpEnabled: Observable<Bool>
    
    private let userInfoManager = UserInfoCoreDataManager()
    
    let signUpSuccess: PublishRelay<Bool> = PublishRelay()
    
    init() {
        // 유효성 검사
        emailValid = email.map { $0.isValidEmail() }
        passwordValid = password.map { $0.count >= 8 }
        confirmPasswordValid = Observable.combineLatest(password, confirmPassword) { $0 == $1 }
        nicknameValid = nickname.map { $0.count > 0 }
        
        // 회원가입 가능 여부
        signUpEnabled = Observable.combineLatest(emailValid, passwordValid, confirmPasswordValid, nicknameValid) {
            $0 && $1 && $2 && $3
        }
    }
    
    func signUp() {
        // 이메일 중복 체크
        let emailExists = userInfoManager.isEmailAlreadyExists(email: email.value)
        
        if emailExists {
            // 이메일 중복 시
            signUpSuccess.accept(false)
        } else {
            // CoreData에 저장
            userInfoManager.saveUserInfo(email: email.value, password: password.value, nickname: nickname.value)
            
            signUpSuccess.accept(true)
        }
    }
}
