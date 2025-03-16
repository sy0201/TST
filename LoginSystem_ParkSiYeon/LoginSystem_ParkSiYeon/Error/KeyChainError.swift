//
//  KeyChainError.swift
//  LoginSystem_ParkSiYeon
//
//  Created by siyeon park on 3/16/25.
//

import Foundation

enum KeyChainError: Error {
    case passwordSaveFailed
    
    var localizedDescription: String {
        switch self {
        case .passwordSaveFailed:
            return "비밀번호 저장에 실패했습니다."
        }
    }
}
