//
//  UIVIewController+Extension.swift
//  TS_PoketmonContact
//
//  Created by siyeon park on 12/12/24.
//

import UIKit

extension UIViewController {
    // 네트워크 상태 체크 및 경고 표시
    func checkNetworkAlert() {
        let alertController = UIAlertController(
            title: "네트워크에 접속할 수 없습니다.",
            message: "네트워크 연결 상태를 확인해주세요.",
            preferredStyle: .alert
        )
        
        let endAction = UIAlertAction(title: "종료", style: .destructive) { _ in
            // 앱 종료
            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                exit(0)
            }
        }
        
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
            // 설정앱 켜주기
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        
        alertController.addAction(endAction)
        alertController.addAction(confirmAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func checkNetworkStatus() {
        if NetworkMonitor.shared.isConnected {
            print("인터넷 연결완료")
        } else {
            print("인터넷 연결실패")
            checkNetworkAlert()
        }
    }
}
