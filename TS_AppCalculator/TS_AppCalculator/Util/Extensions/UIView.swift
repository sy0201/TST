//
//  UIView.swift
//  TS_AppCalculator
//
//  Created by siyeon park on 11/21/24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
}
