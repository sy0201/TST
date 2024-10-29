import Foundation

public class SubtractOperation {
    
    init() {}
    
    // 빼기
    public func subtractOperation(_ a: Int, _ b: Int) -> Int {
        return a - b
    }
    
    public func subtractResult() -> Int {
        let resultInt = subtractOperation(1, 99)
        print("더하기결과 : \(resultInt)")
        return resultInt
    }
}
