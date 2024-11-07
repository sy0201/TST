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
    
    private init() {}
    
    func add(attempts: Int) {
        records.append(attempts)
    }
    
    func showRecords() {
        if records.isEmpty {
            print("기록이 없습니다.")
            return
        }
        
        print("< 게임 기록 보기 >")
        for (index, record) in records.enumerated() {
            print("\(index + 1)번째 게임: 시도 횟수 - \(record)")
        }
    }
}
