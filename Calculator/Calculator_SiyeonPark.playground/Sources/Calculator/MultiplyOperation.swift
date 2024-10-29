import Foundation

public class MultiplyOperation {
    
    public init() {}
    
    // 곱하기
    public func multiplication(_ a: Int, _ b: Int) -> Int {
        return a * b
    }
    
    public func multiplicationResult() -> Int {
        let resultInt = multiplication(2, 4)
        print("곱하기결과 : \(resultInt)")
        return resultInt
    }
}
