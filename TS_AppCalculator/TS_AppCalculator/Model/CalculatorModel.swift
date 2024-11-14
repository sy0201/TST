//
//  CalculatorModel.swift
//  TS_AppCalculator
//
//  Created by siyeon park on 11/14/24.
//

import Foundation

struct CalculatorModel {
    var currentOperation: String?
    var firstInput: String = ""
    var laterInput: String = ""
    
    mutating func arithmetic() -> String {
        guard let operation = currentOperation else {
            return "Error"
        }
        
        // 연산자와 숫자의 상태가 올바르게 설정되어 있어야 계산할 수 있음
        guard let first = Int(firstInput),
              let later = Int(laterInput) else {
            return "연산자사이에 숫자가 배치 되어야 계산이 가능함"
        }
        
        switch operation {
        case "*": return String(first * later)
        case "/": return later != 0 ? String(first / later) : "0으로 나눌 수 없습니다"
        case "+": return String(first + later)
        case "-": return String(first - later)
        default: return "Operation Error"
        }
    }
    
    mutating func reset() {
        firstInput = ""
        laterInput = ""
        currentOperation = nil
    }
}
