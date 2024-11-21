//
//  CalculatorModel.swift
//  TS_AppCalculator
//
//  Created by siyeon park on 11/14/24.
//

import Foundation

struct CalculatorModel {
    private var inputOperator: Enum.ButtonType?  // 입력된 연산자
    private var inputNumber: String = ""      // 입력된 값을 담아두는 변수
    private var resultValue: Int = 0     // 누적된 결과값 저장
    private var displayValue: String = "" // 입력된 값을 화면에 보여줌
    private var isResultDisplay: Bool = false  // 화면에 결과값 존재 여부
    
    // MARK: - 입력된 값을 displayValue,inputNumber에 값을 담아두도록 하는 함수

    mutating func setInputNumber(_ number: String) -> Result<String, InputErrorMessage> {
        if inputNumber.count > 18 {
            return .failure(.checkCountString)
        }
        
        // 화면에 결과값이 false면(있으면)
        if isResultDisplay {
            resetResult()
            isResultDisplay = false
        }

        inputNumber += number
        displayValue += number
        
        return .success(displayValue)
    }
    
    // MARK: - 연산자 입력시 처리하는 함수

    mutating func setInputOperation(_ operation: Enum.ButtonType) -> Result<String, InputErrorMessage> {
        // 첫번째 입력값이 숫자가 아닌 연산자인 경우 아무런 연산없이 리턴
        if inputNumber.isEmpty {
            return .failure(.checkNumberFirst)
        }
        
        if let currentValue = Int(inputNumber) {
            // 이미 숫자가 입력된 이후
            // 연산자가 처음으로 입력된 경우
            // 연산자가 입력된 후에야 resultValue에 처음에 입력한 숫자가 저장되는 로직
            if resultValue == 0 {
                resultValue = currentValue
            } else if let operation = inputOperator {
                // 기존에 연산자가 입력된 경우 적용
                setOperator(operation)
            }
        }
        
        inputOperator = operation
        inputNumber = ""
        displayValue += operation.rawValue
        
        return .success(displayValue)
    }
    
    // MARK: - 입력된 연산자로 연산되도록 하는 함수

    mutating func setOperator(_ operation: Enum.ButtonType) {
        guard let inputNumber = Int(inputNumber) else {
            return
        }
        
        switch operation {
        case .multiplication: resultValue *= inputNumber
        case .division: resultValue /= inputNumber
        case .plus: resultValue += inputNumber
        case .minus: resultValue -= inputNumber
        default: break
        }
    }
    
    // MARK: - 화면에 입력된 값을 보여주는 함수
    mutating func getDisplayValue() -> String {
        return displayValue
    }
    
    // MARK: - 등호 "="버튼 탭시 결과를 보여주는 함수
    
    mutating func getCalculateResult() -> String {
        if let operatorSymbol = inputOperator {
            setOperator(operatorSymbol)
            inputOperator = nil       // 계산 종료 후 연산자 초기화
            inputNumber = ""            // 계산 종료 후 입력 초기화
        }
        
        displayValue = String(resultValue)
        isResultDisplay = true
        return displayValue
    }
    
    // MARK: - 결과 값을 초기화 하는 함수

    mutating func resetResult() {
        resultValue = 0
        inputNumber = ""
        inputOperator = nil
        displayValue = ""
        isResultDisplay = false
    }
}
