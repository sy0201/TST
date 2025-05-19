//
//  UIView+Extension.swift
//  TS_Weather
//
//  Created by siyeon park on 12/3/24.
//

import UIKit

extension UIView {
    func addSubViews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
}
