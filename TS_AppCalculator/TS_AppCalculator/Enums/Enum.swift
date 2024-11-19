//
//  Enum.swift
//  TS_AppCalculator
//
//  Created by siyeon park on 11/18/24.
//

import Foundation

struct Enum {
    public enum OperatorType: String {
        case plus = "+"  // + 더하기
        case minus = "-"  // - 빼기
        case division = "/" // / 나누기
        case multiplication = "*"  // * 곱하기
        case ac = "AC" // 모두 지우기 all clear
        case equalSign = "=" // = 등호
        
        case zero = "0"
        case one = "1"
        case two = "2"
        case three = "3"
        case four = "4"
        case five = "5"
        case six = "6"
        case seven = "7"
        case eight = "8"
        case nine = "9"
    }
    
    public enum InputErrorMessage: Error {
        case checkCountString  // 입력 숫자 제한
        case checkDividingError  // 나누기 에러
        case checkNumberFirst  // 숫자가 아닌 연산저 먼저 입력 시
        
        var errorMessage: String {
            switch self {
            case .checkCountString: "ERROR"
            case .checkDividingError: "ERROR"
            case .checkNumberFirst: "ERROR"
            }
        }
    }
}
