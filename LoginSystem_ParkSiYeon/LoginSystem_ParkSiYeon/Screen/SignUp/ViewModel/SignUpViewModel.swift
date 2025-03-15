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
    
    private let disposeBag = DisposeBag()
    
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
}
