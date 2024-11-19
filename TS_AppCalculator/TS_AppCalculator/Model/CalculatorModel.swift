//
//  CalculatorModel.swift
//  TS_AppCalculator
//
//  Created by siyeon park on 11/14/24.
//

import Foundation

struct CalculatorModel {
    private var selectedOperator: Enum.OperatorType?  // 입력된 연산자 enteredOperator
    private var currentInput: String = ""      // 입력된 값을 담아두는 변수 enteredValue
    private var accumulatedResult: Int = 0     // 누적된 결과를 저장
    private var displayExpression: String = "" // 입력된 값을 화면에 보여줌
    private var isResultDisplay: Bool = false  // 결과값이 있으면 초기화
    
    // MARK: - 입력된 숫자를 displayExpression에도 보여지게하고, currentInput에도 입력된 값을 담아두도록 하는 함수

    mutating func setNumber(_ number: String) {
        if isResultDisplay {
            resetResult()
            isResultDisplay = false
        }
        currentInput += number
        displayExpression += number
    }
    
    // MARK: - 연산자 입력시 처리하는 함수

    mutating func setOperation(_ operation: Enum.OperatorType) {
        // 첫번째 입력값이 숫자가 아닌 연산자인 경우 아무런 연산없이 리턴
        if currentInput.isEmpty {
            return
        }
        
        if let currentValue = Int(currentInput) {
            // 이미 숫자가 입력된 이후
            // 연산자가 처음으로 입력된 경우
            // 연산자가 입력된 후에야 accumulatedResult에 처음에 입력한 숫자가 저장되는 로직
            if accumulatedResult == 0 {
                accumulatedResult = currentValue
            } else if let operation = selectedOperator {
                // 기존에 연산자가 입력된 경우 적용
                applyOperator(operation)
            }
        }
        
        selectedOperator = operation
        currentInput = ""
        displayExpression += operation.rawValue
    }
    
    // MARK: - 입력된 연산자로 연산되도록 하는 함수

    mutating func applyOperator(_ operation: Enum.OperatorType) {
        guard let inputNumber = Int(currentInput) else {
            return
        }
        
        switch operation {
        case .multiplication: accumulatedResult *= inputNumber
        case .division: accumulatedResult /= inputNumber
        case .plus: accumulatedResult += inputNumber
        case .minus: accumulatedResult -= inputNumber
        default: break
        }
    }
    
    mutating func getDisplayExpression() -> String {
        return displayExpression
    }
    
    // MARK: - 등호 "="버튼 탭시 결과를 보여주는 함수
    mutating func getCalculateResult() -> String {
        if let operatorSymbol = selectedOperator {
            applyOperator(operatorSymbol)
            selectedOperator = nil       // 계산 종료 후 연산자 초기화
            currentInput = ""            // 계산 종료 후 입력 초기화
        }
        
        displayExpression = String(accumulatedResult)
        isResultDisplay = true
        return displayExpression
    }

    
    // MARK: - 결과 값을 초기화 하는 함수

    mutating func resetResult() {
        accumulatedResult = 0
        currentInput = ""
        selectedOperator = nil
        displayExpression = ""
        isResultDisplay = false
    }
}
