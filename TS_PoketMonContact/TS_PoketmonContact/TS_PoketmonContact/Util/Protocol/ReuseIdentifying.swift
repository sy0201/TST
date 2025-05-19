//
//  ReuseIdentifying.swift
//  TS_PoketmonContact
//
//  Created by siyeon park on 12/8/24.
//

import Foundation

protocol ReuseIdentifying: AnyObject {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
