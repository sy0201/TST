//
//  SignUpError.swift
//  LoginSystem_ParkSiYeon
//
//  Created by siyeon park on 3/16/25.
//

import Foundation

enum SignUpError: Error {
    case emailAlreadyExists  // 중복 이메일 체크
    case saveError
    
    var localizedDescription: String {
        switch self {
        case .emailAlreadyExists:
            return "이미 등록된 이메일입니다."
        case .saveError:
            return "회원가입 중 오류가 발생했습니다."
        }
    }
}
