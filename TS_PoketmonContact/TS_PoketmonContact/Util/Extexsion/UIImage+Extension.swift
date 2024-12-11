//
//  UIImage+Extension.swift
//  TS_PoketmonContact
//
//  Created by siyeon park on 12/10/24.
//

import Kingfisher
import UIKit

extension UIImageView {
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        // Kingfisher로 이미지 비동기 로드
        self.kf.setImage(with: url, options: [
            .cacheOriginalImage  // 원본 이미지를 캐시하도록 설정
        ]) { result in
            switch result {
            case .success(let value):
                print("이미지 로딩 성공: \(value.image)")
            case .failure(let error):
                print("이미지 로딩 실패: \(error.localizedDescription)")
            }
        }
    }
}
