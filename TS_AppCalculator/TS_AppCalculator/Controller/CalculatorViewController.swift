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
        calculatorView.buttonTapHandler = { [weak self] buttonType in
            if let operatorType = Enum.OperatorType(rawValue: buttonType) {
                self?.handleButtonTap(operatorType)
            }
        }
    }
    
    func handleButtonTap(_ buttonType: Enum.OperatorType) {
        switch buttonType {
        case .ac:
            calculatorModel.resetResult()
            calculatorView.resultLabel.text = "0"
            
        case .equalSign:
            let result = calculatorModel.getCalculateResult()
            calculatorView.resultLabel.text = result
            
        case .plus, .minus, .multiplication, .division:
            calculatorModel.setInputOperation(buttonType)
            calculatorView.resultLabel.text = calculatorModel.getDisplayExpression()
            
        default:
            let result = calculatorModel.setInputNumber(buttonType.rawValue)
            switch result {
            case .success(let displayExpression):
                calculatorView.resultLabel.text = displayExpression
                calculatorView.limitedString(displayExpression)
            case .failure(let error):
                print("Error occurred: \(error.errorMessage)")
            }
        }
    }
}
