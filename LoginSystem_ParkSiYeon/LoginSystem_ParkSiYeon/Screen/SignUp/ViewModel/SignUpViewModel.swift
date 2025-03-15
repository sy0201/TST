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
    
    let emailErrorText: Observable<String?>
    let passwordErrorText: Observable<String?>
    let confirmPasswordErrorText: Observable<String?>
    let nicknameErrorText: Observable<String?>
    
    let signUpEnabled: Observable<Bool>
    let signUpSuccess: PublishRelay<Bool> = PublishRelay()
    
    private let userInfoManager = UserInfoCoreDataManager()
    
    init() {
        // 유효성 검사
        emailErrorText = email.map { email in
            if email.isEmpty {
                return "이메일을 입력해주세요."
            }
            
            return email.isValidEmail() ? nil : "올바른 이메일 형식을 입력해주세요."
        }
        
        // 비밀번호 유효성 검사
        passwordErrorText = password.map { password in
            if password.isEmpty {
                return "비밀번호를 입력해주세요."
            }
            
            return password.count >= 8 ? nil : "비밀번호는 최소 8자 이상이어야 합니다."
        }
        
        // 비밀번호 확인 유효성 검사
        confirmPasswordErrorText = Observable.combineLatest(password, confirmPassword) { password, confirm in
            if confirm.isEmpty {
                return "비밀번호 확인해주세요."
            }
            
            return password == confirm ? nil : "비밀번호가 일치하지 않습니다."
        }
        
        // 닉네임 유효성 검사
        nicknameErrorText = nickname.map { nickname in
            if nickname.isEmpty {
                return "닉네임을 입력해주세요."
            }
            
            return nickname.count >= 2 ? nil : "닉네임은 최소 2자 이상이어야 합니다."
        }
        
        // 회원가입 버튼 활성화 조건
        // 에러 상태를 Bool로 변환
        let isEmailValid = emailErrorText.map { $0 == nil }
        let isPasswordValid = passwordErrorText.map { $0 == nil }
        let isConfirmPasswordValid = confirmPasswordErrorText.map { $0 == nil }
        let isNicknameValid = nicknameErrorText.map { $0 == nil }
        
        // 회원가입 가능 여부
        signUpEnabled = Observable.combineLatest(
            isEmailValid,
            isPasswordValid,
            isConfirmPasswordValid,
            isNicknameValid
        ) { $0 && $1 && $2 && $3 }
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
