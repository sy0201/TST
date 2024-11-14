//
//  CalculatorViewController.swift
//  TS_AppCalculator
//
//  Created by siyeon park on 11/13/24.
//

import UIKit

final class CalculatorViewController: UIViewController {
    private let calculatorModel = CalculatorModel()
    private let calculatorView = CalculatorView()
    
    
    override func loadView() {
        view = calculatorView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatorView.backgroundColor = .black
    }
}
