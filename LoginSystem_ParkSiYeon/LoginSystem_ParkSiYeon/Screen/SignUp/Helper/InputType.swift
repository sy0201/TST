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
    
    var errorMessage: String {
        switch self {
        case .email:
            return "올바른 이메일 형식이 아닙니다."
            
        case .password:
            return "비밀번호는 8자 이상 이어야 합니다."
            
        case .confirmPassword:
            return "비밀번호가 일치하지 않습니다."
            
        case .nickname:
            return "닉네임은 1글자 이상 이어야 합니다."
        }
    }
}
