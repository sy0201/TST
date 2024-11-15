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
    
    override func loadView() {
        view = calculatorView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatorView.buttonTapHandler = { [weak self] buttonTitle in
            self?.handleButtonTap(buttonTitle)
        }
    }
}

private extension CalculatorViewController {
    func handleButtonTap(_ buttonTitle: String) {
        switch buttonTitle {
        case "AC":
            calculatorModel.resetResult()
            calculatorView.resultLabel.text = "0"
            
        case "=":
            let result = calculatorModel.calculateResult()
            calculatorView.resultLabel.text = result
            
        case "+", "-", "*", "/":
            calculatorModel.inputOperation(buttonTitle)
            calculatorView.resultLabel.text = calculatorModel.displayExpression
            
        default:
            calculatorModel.inputNumber(buttonTitle)
            calculatorView.resultLabel.text = calculatorModel.displayExpression
        }
    }
}
