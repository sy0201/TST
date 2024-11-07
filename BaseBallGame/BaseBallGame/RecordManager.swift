//
//  RecordManager.swift
//  BaseBallGame
//
//  Created by siyeon park on 11/7/24.
//

import Foundation

public class RecordManager {
    static let shared = RecordManager()
    
    var records: [Int] = []
    var currentAttempts: Int?
    
    private init() {}
    
    // MARK: - 게임 시도 횟수 추가 함수

    func add(attempts: Int) {
        records.append(attempts)
        currentAttempts = nil
    }
    
    // MARK: - 게임 시도 횟수 기록 함수

    func showRecords(isGameInProgress: Bool) {
        if records.isEmpty {
            print("기록이 없습니다.")
            return
        }
        for (index, record) in records.enumerated() {
            print("< 게임 기록 보기 >")
            print("\(index + 1)번째 게임: 시도 횟수 - \(record)")
        }
        
        if isGameInProgress, let currentAttempts = currentAttempts {
            for (index, record) in records.enumerated() {
                print("< 게임 기록 보기 >")
                print("\(index + 1)번째 게임: 시도 횟수 - \(record)")
            }
        }
    }
}
