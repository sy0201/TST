//
//  InputType.swift
//  LoginSystem_ParkSiYeon
//
//  Created by siyeon park on 3/14/25.
//

import UIKit

enum InputType {
    case email
    case password
    case confirmPassword
    case nickname
    
    var placeholder: String {
        switch self {
        case .email:
            return "이메일을 입력해주세요."
            
        case .password:
            return "비밀번호를 입력해주세요."
            
        case .confirmPassword: 
            return "비밀번호를 확인해주세요."
            
        case .nickname: 
            return "닉네임을 입력해주세요."
        }
    }
    
    var errorMessage: String {
        switch self {
        case .email:
            return "올바른 이메일 형식이 아닙니다."
            
        case .password:
            return "비밀번호는 8자 이상 이어야 합니다."
            
        case .confirmPassword:
            return "비밀번호가 일치하지 않습니다."
            
        case .nickname:
            return "닉네임은 2자 이상 이어야 합니다."
        }
    }
    
    func isValidInput(_ text: String, confirmPassword: String? = nil) -> Bool {
        switch self {
        case .email:
            return text.contains("@") && text.contains(".") && (6...20).contains(text.count)
            
        case .password:
            return text.count >= 8
            
        case .confirmPassword:
            return text == confirmPassword
            
        case .nickname:
            return text.count >= 2
        }
    }
}
