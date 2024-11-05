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
        print("< 게임을 시작합니다 >")
        print("숫자를 입력하세요")
        
        while true {
            // 1. 유저에게 입력값 받음
            guard let input = readLine() else {
                print("입력이 올바르지 않습니다. 다시 시도해 주세요.")
                continue
            }
            
            // 2. 정수로 변환되지 않는 경우 반복문 처음으로 돌아가기
            
            // whitespaces로 input의 앞뒤 공백문자 삭제
            let trimmedInput = input.trimmingCharacters(in: .whitespaces)
            
            // 3. 세자리가 아니거나, 0을 가지거나 특정 숫자가 두번 사용된 경우 반복문 처음으로 돌아가기
            if trimmedInput.count != 3 {
                print("올바르지 않은 입력값입니다")
                continue
            } else if Array(trimmedInput).contains("0") {
                print("올바르지 않은 입력값입니다")
                continue
            } else if trimmedInput == answer {
                print("스트라이크")
                continue
            }
            
            // 4. 정답과 유저의 입력값을 비교하여 스트라이크/볼을 출력하기
            let strikeCount = getStrikeCount(input: trimmedInput, answer: answer)
            let ballCount = getBallCount(input: trimmedInput, answer: answer)
            
            // 만약 정답이라면 break 호출하여 반복문 탈출
            if strikeCount == 3 {
                print("정답입니다!")
                break
            } else {
                print("\(strikeCount)스트라이크 \(ballCount)볼")
            }
        }
    }
    
    func makeAnswer() -> String {
        // Set을 사용하여 3개의 숫자 중 중복값 자동으로 걸러내기
        var numbers: Set<Int> = []
        
        // 첫번째 자리에 0이 되지 않도록 구현
        while numbers.count < 3 {
            if numbers.isEmpty {
                let firstInt = Int.random(in: 1...9)
                numbers.insert(firstInt)
            } else {
                let randomInt = Int.random(in: 1...9)
                numbers.insert(randomInt)
            }
        }
        
        // randomInt의 3개 수를 map함수로 Int를 String으로 변환
        let result = numbers.map { String($0) }.joined()
        
        return result
    }
    
    // input의 숫자가 answer와 비교 후 동일한 index에 위치하며, 동일한 숫자인 경우(순서상관있음)
    func getStrikeCount(input: String, answer: String) -> Int {
        var strikeCount = 0
        
        for (index, inputString) in input.enumerated() {
            if answer[answer.index(answer.startIndex, offsetBy: index)] == inputString {
                strikeCount += 1
            }
        }
        
        return strikeCount
    }
    
    // input의 숫자가 answer와 비교 후 하나 이상 포함하는 경우(순서상관없음)
    func getBallCount(input: String, answer: String) -> Int {
        var ballCount = 0
        
        for (index, inputString) in input.enumerated() {
            // inputString이 answer에 포함되었거나 && inputString문자와 answer의 첫번째 인덱스와 다른지 확인 != inputString과 다른위치에 동일한 문자가 포함하는지 확인
            if answer.contains(inputString) && answer.index(answer.startIndex, offsetBy: index) != answer.firstIndex(of: inputString) {
                ballCount += 1
            }
        }
        
        return ballCount
    }
}
