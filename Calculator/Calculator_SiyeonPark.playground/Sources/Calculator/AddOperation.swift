import Foundation

public class AddOperation {
    
    init() {}
    
    // 더하기
    public func addOperation(_ a: Int, _ b: Int) -> Int {
        return a + b
    }
    
    public func addResult() -> Int {
        let resultInt = addOperation(9, 14)
        print("더하기결과 : \(resultInt)")
        return resultInt
    }
}
