//
//  ReuseIdentifying.swift
//  TS_Weather
//
//  Created by siyeon park on 12/3/24.
//

protocol ReuseIdentifying: AnyObject {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
