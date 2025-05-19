//
//  InputError.swift
//  TS_AppCalculator
//
//  Created by siyeon park on 11/21/24.
//

import Foundation

public enum InputErrorMessage: Error {
    case checkCountString  // 입력 숫자 제한
    case checkNumberFirst  // 숫자가 아닌 연산저 먼저 입력 시
    
    var errorMessage: String {
        switch self {
        case .checkCountString: "ERROR"
        case .checkNumberFirst: "ERROR"
        }
    }
}
