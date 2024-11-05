//
//  BaseballGame.swift
//  BaseBallGame
//
//  Created by siyeon park on 11/5/24.
//

import Foundation

final class BaseballGame {
    func startGame() {
        let answer = makeAnswer()
        print("answer : \(answer)")
    }
    
    func makeAnswer() -> [Int] {
        // Set을 사용하여 3개의 숫자 중 중복값 자동으로 걸러내기
        var numbers: Set<Int> = []
        
        while numbers.count < 3 {
            let randomInt = Int.random(in: 1...9)
            numbers.insert(randomInt)
        }
        
        return Array(numbers)
    }
}
