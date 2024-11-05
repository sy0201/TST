//
//  main.swift
//  BaseBallGame
//
//  Created by siyeon park on 11/5/24.
//

import Foundation

var greet = "Hi, Sia!"
var fooClosure = { 
    print(greet)
}
greet = "bye~"
let sayBye = fooClosure
sayBye()

