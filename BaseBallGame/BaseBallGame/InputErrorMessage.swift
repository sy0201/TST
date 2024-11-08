//
//  InputErrorMessage.swift
//  BaseBallGame
//
//  Created by siyeon park on 11/7/24.
//

import Foundation

enum InputErrorMessage: LocalizedError {
    case checkThreeString
    case checkFirstString
    case checkUniqueString
    case checkOtherString
    
    var errorMessage: String? {
        switch self {
        case .checkThreeString:
            return "올바르지 않은 입력값입니다. 3자리 숫자를 입력해주세요."
        case .checkFirstString:
            return "올바르지 않은 입력값입니다. 첫번째 숫자는 0이 될 수 없습니다."
        case .checkUniqueString:
            return "올바르지 않은 입력값입니다. 중복되지 않는 숫자를 입력해주세요."
        case .checkOtherString:
            return "올바르지 않은 입력값입니다. 숫자만 입력해주세요."
        }
    }
}
