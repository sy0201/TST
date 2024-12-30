//
//  UIView+Extension.swift
//  SearchBook
//
//  Created by t2023-m0019 on 12/30/24.
//

import UIKit

extension UIView {
    func addSubViews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
}
