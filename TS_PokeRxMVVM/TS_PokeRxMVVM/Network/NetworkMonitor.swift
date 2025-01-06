//
//  NetworkMonitor.swift
//  TS_PokeRxMVVM
//
//  Created by t2023-m0019 on 1/6/25.
//

import Foundation
import Network

final class NetworkMonitor {
    private let monitor: NWPathMonitor
    private let queue = DispatchQueue(label: "NetworkMonitorQueue")
    
    static let shared = NetworkMonitor()
    
    // 네트워크 상태를 저장할 변수
    private(set) var isConnected: Bool = true
    
    private init() {
        monitor = NWPathMonitor()
        monitor.start(queue: queue)
        
        // 네트워크 상태가 변할 때마다 실행되는 블록
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
    }
    
    func isNetworkAvailable() -> Bool {
        return isConnected
    }
}
