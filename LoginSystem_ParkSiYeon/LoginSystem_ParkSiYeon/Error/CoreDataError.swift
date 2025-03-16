//
//  CoreDataError.swift
//  LoginSystem_ParkSiYeon
//
//  Created by siyeon park on 3/16/25.
//

import Foundation

enum CoreDataError: Error {
    case saveFailed
    case contextSaveFailed
    
    var localizedDescription: String {
        switch self {
        case .saveFailed:
            return "CoreData 저장에 실패했습니다."
        case .contextSaveFailed:
            return "Context 저장에 문제가 발생했습니다."
        }
    }
}
