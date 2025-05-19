//
//  Protocol.swift
//  TS_AppCalculator
//
//  Created by siyeon park on 11/22/24.
//

import Foundation

protocol ButtonTypeDelegate: AnyObject {
    func didTapButton(for buttonType: Enum.ButtonType)
}
