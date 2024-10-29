import Foundation

public class DivideOperation {
    
    init() {}
    
    // 나누기
    public func divideOperation(_ a: Double, _ b: Double) -> Double {
        return a / b
    }
    
    public func divideResult() -> Double {
        let resultInt = divideOperation(3, 8)
        print("나누기결과 : \(resultInt)")
        if resultInt < 0 {
            return resultInt
        } else {
            return Double(resultInt)
        }
    }
}
