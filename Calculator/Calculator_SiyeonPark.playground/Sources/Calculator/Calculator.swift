import Foundation

public class Calculator {
    
    private let multiply: MultiplyOperation
    private let divide: DivideOperation
    private let add: AddOperation
    private let subtract: SubtractOperation
    
    public init() {
        self.multiply = MultiplyOperation()
        self.divide = DivideOperation()
        self.add = AddOperation()
        self.subtract = SubtractOperation()
    }

    // 곱하기 함수
    public func setMultiplication(a: Int, b: Int) -> Int {
        return multiply.multiplication(a, b)
    }
    
    // 나누기 함수
    public func setDivision(a: Double, b: Double) -> Double {
        return divide.divideOperation(a, b)
    }
    
    // 더하기 함수
    public func setPlus(a: Int, b: Int) -> Int {
        return add.addOperation(a, b)
    }
    
    // 빼기 함수
    public func setMinus(a: Int, b: Int) -> Int {
        return subtract.subtractOperation(a, b)
    }
}
