//
//  CalculatorViewController.swift
//  CalculatorApp
//
//  Created by siyeon park on 11/11/24.
//

import UIKit

final class CalculatorViewController: UIViewController {
    private let maxLabelCount = 17
    var currentOperation: String?
    var firstInput: String = ""
    var laterInput: String = ""
    
    let buttonList = [
        ["7", "8", "9", "+"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "*"],
        ["AC", "0", "=", "/"]
    ]
    
    private let resultLabel: UILabel = {
        let resultLabel = UILabel()
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.textAlignment = .right
        resultLabel.font = .systemFont(ofSize: 60, weight: .bold)
        resultLabel.textColor = .white
        resultLabel.adjustsFontSizeToFitWidth = true  // label이 화면너비만큼 입력시 폰트 사이즈 작아지도록 설정
        resultLabel.minimumScaleFactor = 0.5  // label 50%까지 줄어들 수 있도록 설정
        resultLabel.lineBreakMode = .byTruncatingTail
        
        return resultLabel
    }()
    
    private let verticalStackView: UIStackView = {
        let verticalStackView = UIStackView()
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .equalSpacing
        verticalStackView.spacing = 10
        
        return verticalStackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraint()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        // buttonList를 한줄씩 담는곳
        for row in buttonList {
            let buttonRowStack = makeHorizontalStackView(row)
            verticalStackView.addArrangedSubview(buttonRowStack)
        }
    }
    
    private func setupConstraint() {
        view.addSubview(resultLabel)
        view.addSubview(verticalStackView)
        
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            resultLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            resultLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            resultLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 60),
            verticalStackView.widthAnchor.constraint(equalToConstant: 350),
            verticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    // MARK: - 제한된 입력값만 노출해주는 함수

    private func limitedString(_ text: String) {
        if text.count > maxLabelCount {
            let limitedLabel = String(text.prefix(maxLabelCount))
            resultLabel.text = limitedLabel
            print("limitedLabel\(limitedLabel)")
            print("limitedLabel\(limitedLabel.count)")
        } else {
            resultLabel.text = text
        }
    }
    
    // MARK: - buttonList를 가로 StackView를 return 하는 함수

    private func makeHorizontalStackView(_ titles: [String]) -> UIStackView {
        var buttons: [UIButton] = []
        
        // 각 버튼의 title을 설정
        for title in titles {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 30)
            button.backgroundColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
            button.widthAnchor.constraint(equalToConstant: 80).isActive = true
            button.heightAnchor.constraint(equalToConstant: 80).isActive = true
            button.layer.cornerRadius = 40
            if title == "+" || title == "-" || title == "*" || title == "/" || title == "AC" || title == "=" {
                button.backgroundColor = UIColor(red: 252/255, green: 134/255, blue: 0/255, alpha: 1.0)
            } else {
                button.backgroundColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
            }
            
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            
            buttons.append(button)
        }
        
        // 가로 stackView 설정
        let horizontalStackView = UIStackView(arrangedSubviews: buttons)
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.spacing = 10
        horizontalStackView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        return horizontalStackView
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.currentTitle else {
            return
        }
        
        switch buttonTitle {
        case "AC": 
            resetResult()
        default:
            if resultLabel.text == "0" {
                resultLabel.text = buttonTitle
            } else if resultLabel.text != "0" {
                resultLabel.text = (resultLabel.text ?? "") + buttonTitle
            }
            limitedString(resultLabel.text ?? "")
        }
    }
    
    // MARK: - AC 버튼 탭시 결과값 reset 하는 함수

    private func resetResult() {
        currentOperation = nil
        firstInput = ""
        laterInput = ""
        resultLabel.text = "0"
    }
}
