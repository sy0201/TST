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
        setupBind()
    }
}

private extension CalculatorViewController {
    func setupBind() {
        calculatorView.buttonTapHandler = { [weak self] buttonTitle in
            self?.handleButtonTap(buttonTitle)
        }
    }
    
    func handleButtonTap(_ buttonTitle: String) {
        switch buttonTitle {
        case "AC":
            calculatorModel.resetResult()
            calculatorView.resultLabel.text = "0"
            
        case "=":
            let result = calculatorModel.getCalculateResult()
            calculatorView.resultLabel.text = result
            
        case "+", "-", "*", "/":
            calculatorModel.setOperation(buttonTitle)
            calculatorView.resultLabel.text = calculatorModel.displayExpression
            
        default:
            calculatorModel.setNumber(buttonTitle)
            calculatorView.resultLabel.text = calculatorModel.displayExpression
        }
    }
}
