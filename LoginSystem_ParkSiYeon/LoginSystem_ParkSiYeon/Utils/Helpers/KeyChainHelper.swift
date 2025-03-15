//
//  KeyChainHelper.swift
//  LoginSystem_ParkSiYeon
//
//  Created by siyeon park on 3/15/25.
//

import Foundation
import Security

final class KeyChainHelper {
    static func savePassword(password: String, for account: String) -> Bool {
        let data = password.data(using: .utf8)!
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecValueData: data
        ]
        
        SecItemDelete(query as CFDictionary) // 기존에 저장된 값 삭제
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    static func getPassword(for account: String) -> String? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecReturnData: kCFBooleanTrue!,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess, let data = result as? Data, let password = String(data: data, encoding: .utf8) {
            return password
        } else {
            return nil
        }
    }
}
