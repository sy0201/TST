import UIKit

class Calculator {
    
    // 곱하기
    func multiplication(_ a: Int, _ b: Int) -> Int {
        return a * b
    }
    
    func multiplicationResult() -> Int {
        let resultInt = multiplication(2, 4)
        print("곱하기결과 : \(resultInt)")
        return resultInt
    }
    
    // 나누기
    func divideOperation(_ a: Double, _ b: Double) -> Double {
        return a / b
    }
    
    func divideResult() -> Double {
        let resultInt = divideOperation(3, 8)
        print("나누기결과 : \(resultInt)")
        if resultInt < 0 {
            return resultInt
        } else {
            return Double(resultInt)
        }
    }
    
    // 더하기
    func addOperation(_ a: Int, _ b: Int) -> Int {
        return a + b
    }
    
    func addResult() -> Int {
        let resultInt = addOperation(9, 14)
        print("더하기결과 : \(resultInt)")
        return resultInt
    }
    
    // 빼기
    func subtractOperation(_ a: Int, _ b: Int) -> Int {
        return a - b
    }
    
    func subtractResult() -> Int {
        let resultInt = subtractOperation(1, 99)
        print("더하기결과 : \(resultInt)")
        return resultInt
    }
}

let calculator = Calculator()
calculator.multiplicationResult()
calculator.divideResult()
calculator.addResult()
calculator.subtractResult()
