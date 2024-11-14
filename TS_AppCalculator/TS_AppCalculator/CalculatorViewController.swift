//
//  CalculatorViewController.swift
//  TS_AppCalculator
//
//  Created by siyeon park on 11/13/24.
//

import UIKit

final class CalculatorViewController: UIViewController {
    private var calculatorModel = CalculatorModel()
    private let calculatorView = CalculatorView()
    private var currentExpression = ""
    
    override func loadView() {
        view = calculatorView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatorView.buttonTapHandler = { [weak self] buttonTitle in
            self?.handleButtonTap(buttonTitle)
        }
    }
    
    private func handleButtonTap(_ buttonTitle: String) {
        switch buttonTitle {
        case "AC":
            calculatorModel.reset()
            currentExpression = ""
            calculatorView.resultLabel.text = "0"
            
        case "=":
            let result = calculatorModel.arithmetic()
            calculatorView.resultLabel.text = result
            calculatorModel.reset()
            currentExpression = ""
            
        case "+", "-", "*", "/":
            if !calculatorModel.firstInput.isEmpty {
                calculatorModel.currentOperation = buttonTitle
                currentExpression += buttonTitle
                calculatorView.resultLabel.text = currentExpression
            }
            
        default:
            if calculatorModel.currentOperation == nil {
                calculatorModel.firstInput += buttonTitle
            } else {
                calculatorModel.laterInput += buttonTitle
            }
            currentExpression += buttonTitle
            calculatorView.resultLabel.text = currentExpression
        }
    }
}
