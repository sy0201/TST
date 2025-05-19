//
//  UIStackView+Extension.swift
//  LoginSystem_ParkSiYeon
//
//  Created by siyeon park on 3/14/25.
//

import UIKit

extension UIStackView {
    func addArrangedSubViews(_ views: [UIView]) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
