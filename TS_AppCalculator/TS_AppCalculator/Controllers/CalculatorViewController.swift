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
        self.calculatorView.delegate = self
    }
}

extension CalculatorViewController: ButtonTypeDelegate {
    func didTapButton(for buttonType: Enum.ButtonType) {
        switch buttonType {
        case .ac:
            calculatorModel.resetResult()
            calculatorView.displayLabel.text = "0"
            
        case .equalSign:
            let result = calculatorModel.getCalculateResult()
            calculatorView.displayLabel.text = result
            
        case .plus, .minus, .multiplication, .division:
            let result = calculatorModel.setInputOperation(buttonType)
            switch result {
            case .success(_):
                calculatorView.displayLabel.text = calculatorModel.getDisplayValue()
            case .failure(let failure):
                print("Error occurred: \(failure.errorMessage)")
            }
            
        default:
            let result = calculatorModel.setInputNumber(buttonType.rawValue)
            switch result {
            case .success(let displayValue):
                calculatorView.displayLabel.text = displayValue
                calculatorView.limitedString(displayValue)
            case .failure(let failure):
                print("Error occurred: \(failure.errorMessage)")
            }
        }
    }
}
