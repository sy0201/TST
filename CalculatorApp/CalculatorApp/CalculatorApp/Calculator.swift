//
//  Calculator.swift
//  CalculatorApp
//
//  Created by siyeon park on 11/13/24.
//

import Foundation

public class Calculator: ArithmeticProtocol {
    
    public init() {}
    
    public func arithmetic(a: Double, b: Double, operation: String) -> Double {
        
        switch operation {
        case "*": return a * b
        case "/": return a / b
        case "+": return a + b
        case "-": return a - b
        case "%": return a.truncatingRemainder(dividingBy: b)
        default:
            print("정확히 입력해 주세요.")
            return a * b
        }
    }
}
