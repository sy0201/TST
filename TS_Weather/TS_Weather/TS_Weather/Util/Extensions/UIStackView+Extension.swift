//
//  UIStackView+Extension.swift
//  TS_Weather
//
//  Created by siyeon park on 12/3/24.
//

import UIKit

extension UIStackView {
    func addArrangedSubViews(_ views: [UIView]) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
