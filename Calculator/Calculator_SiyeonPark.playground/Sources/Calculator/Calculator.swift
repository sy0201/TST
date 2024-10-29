import Foundation

public class Calculator: ArithmeticProtocol {
    
    public init() {}
    
    public func arithmetic(a: Double, b: Double, operation: String) -> Double {
        
        switch operation {
        case "*": return a * b
        case "/": return a / b
        case "+": return a + b
        case "-": return a - b
        default:
            print("정확히 입력해 주세요.")
            return a * b
        }
    }
}
