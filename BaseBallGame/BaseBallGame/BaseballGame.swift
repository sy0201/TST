//
//  BaseballGame.swift
//  BaseBallGame
//
//  Created by siyeon park on 11/5/24.
//

import Foundation

final class BaseballGame {
    var recordManager = RecordManager.shared
    var gameInProgress = false
    
    // MARK: - 게임 메뉴 선택 함수

    func selectGameMenu() {
        let selectMenu = """
        환영합니다! 원하시는 번호를 입력해주세요
        1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기
        """
        print(selectMenu)
        
        while true {
            guard let selectMenu = readLine() else {
                print("올바르지 않은 입력입니다. 다시 시도해주세요.")
                continue
            }
            
            switch selectMenu {
            // 1. 게임 시작하기 버튼 입력 케이스
            case "1":
                startGame()
                
            // 2. 게임 기록 보기 버튼 입력 케이스
            case "2":
                recordManager.showRecords(isGameInProgress: gameInProgress)
                
            // 3. 종료하기 버튼 입력 케이스
            case "3":
                print("< 숫자 야구 게임을 종료합니다 >")
                return

            default:
                print("올바르지 않은 입력입니다. 1, 2 또는 3을 입력해주세요.")
            }
            
            if gameInProgress {
                break
            }
        }
    }
    
    // MARK: - 게임 시작 함수

    func startGame() {
        gameInProgress = true
        let answer = makeAnswer()
        var attempts = 0
        recordManager.currentAttempts = 0
        
        print("< 게임을 시작합니다 >")
        print("숫자를 입력하세요")

        while true {
            // 유저에게 입력값 받음
            guard let input = readLine() else {
                print("입력이 올바르지 않습니다. 다시 시도해 주세요.")
                continue
            }
            
            do {
                // 입력값 검증 확인
                try isValidateInput(input: input)
            } catch let error as LocalizedError {
                print(error.errorDescription ?? "알 수 없는 에러가 발생했습니다.")
                continue
            } catch {
                print("알 수 없는 에러가 발생했습니다. \(error)")
                continue
            }
            
            attempts += 1
            recordManager.currentAttempts = attempts
            
            // 정답과 유저의 입력값을 비교하여 스트라이크/볼을 출력하기
            let strikeCount = getStrikeCount(input: input, answer: answer)
            let ballCount = getBallCount(input: input, answer: answer)
            
            // 만약 정답이라면 break 호출하여 반복문 탈출
            if strikeCount == 3 && input == answer {
                print("ALL 스트라이크! 정답입니다")
                recordManager.add(attempts: attempts)
                break
            } else if strikeCount == 0 && ballCount == 0 {
                // 정답과 매치된 숫자가 하나도 없다면
                print("Nothing")
                continue
            } else {
                print("\(strikeCount)스트라이크 \(ballCount)볼")
            }
        }
        gameInProgress = false
    }
    
    // MARK: - 정답 생성 함수
    
    func makeAnswer() -> String {
        // Set을 사용하여 3개의 숫자 중 중복값 자동으로 걸러내기
        var numbers: Set<Int> = []
        
        // 0번째 자리에 0이 되지 않도록 구현
        while numbers.count < 3 {
            if numbers.isEmpty {
                let firstInt = Int.random(in: 1...9)
                numbers.insert(firstInt)
                print("firstInt\(firstInt)")
            } else {
                let randomInt = Int.random(in: 0...9)
                numbers.insert(randomInt)
                print("randomInt\(randomInt)")
            }
        }
        
        // randomInt의 3개 수를 map함수로 Int를 String으로 변환
        let result = numbers.map { String($0) }.joined()
        
        return result
    }
    
    // MARK: - 유저 input값 검증 함수

    func isValidateInput(input: String) throws {
        // 정수로 변환되지 않는 경우 반복문 처음으로 돌아가기
        // whitespaces로 input의 앞뒤 공백문자 삭제
        let trimmedInput = input.trimmingCharacters(in: .whitespaces)

        // 입력값이 3자리가 아닐때 안내메시지 출력
        if trimmedInput.count != 3 {
            throw InputErrorMessage.checkThreeString
        }
        
        // 0번째에 0입력시 안내메시지 출력
        if trimmedInput.first == "0" {
            throw InputErrorMessage.checkFirstString
        }
        
        // 중복 숫자 입력시 안내메시지 출력
        let uniqueString = Set(trimmedInput)
        if uniqueString.count != 3 {
            throw InputErrorMessage.checkUniqueString
        }
        
        // 숫자 이외 입력시 안내메시지 출력
        if !trimmedInput.allSatisfy({ $0.isNumber }) {
            throw InputErrorMessage.checkOtherString
        }
    }
    
    /// input의 숫자가 answer와 비교 후 동일한 index에 위치하며, 동일한 숫자인 경우(순서상관있음)의 함수
    /// - Parameters:
    ///   - input: 사용자 입력 값
    ///   - answer: makeAnswer함수를 통해 생성된 정답 값
    /// - Returns: 정답값과 같은 위치에 입력값이 있는 경우의 숫자를 return 해준다.
    func getStrikeCount(input: String, answer: String) -> Int {
        var strikeCount = 0
        
        for (index, inputString) in input.enumerated() {
            if answer[answer.index(answer.startIndex, offsetBy: index)] == inputString {
                strikeCount += 1
            }
        }
        
        return strikeCount
    }
    
    
    /// input의 숫자가 answer와 비교 후 하나 이상 포함하는 경우(순서상관없음)의 함수
    /// - Parameters:
    ///   - input: 사용자 입력 값
    ///   - answer: makeAnswer함수를 통해 생성된 정답 값
    /// - Returns: 정답값과 다른 위치면서 동일한 값의 입력값이 있는 경우의 숫자를 return 해준다.
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
