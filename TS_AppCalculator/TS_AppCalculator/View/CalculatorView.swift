//
//  CalculatorView.swift
//  TS_AppCalculator
//
//  Created by siyeon park on 11/14/24.
//

import UIKit

final class CalculatorView: UIView {
    private let maxLabelCount = 17
    var buttonTapHandler: ((String) -> Void)?
    
    let resultLabel: UILabel = {
        let resultLabel = UILabel()
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.textAlignment = .right
        resultLabel.font = .systemFont(ofSize: 60, weight: .bold)
        resultLabel.textColor = .white
        resultLabel.adjustsFontSizeToFitWidth = true  // label이 화면너비만큼 입력시 폰트 사이즈 작아지도록 설정
        resultLabel.minimumScaleFactor = 0.5          // label 50%까지 줄어들 수 있도록 설정
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
    
    private let buttonList = [
        ["7", "8", "9", "+"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "*"],
        ["AC", "0", "=", "/"]
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CalculatorView {
    func setupUI() {
        self.backgroundColor = .black
        
        // buttonList를 한줄씩 담는곳
        for row in buttonList {
            let buttonRowStack = makeHorizontalStackView(row)
            verticalStackView.addArrangedSubview(buttonRowStack)
        }
    }
    
    func setupConstraint() {
        addSubview(resultLabel)
        addSubview(verticalStackView)
        
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 200),
            resultLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            resultLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            resultLabel.heightAnchor.constraint(equalToConstant: 100),
            
            verticalStackView.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 60),
            verticalStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            verticalStackView.widthAnchor.constraint(equalToConstant: 350),
            verticalStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    // MARK: - 계산기 입력 숫자 제한 함수

    func limitedString(_ text: String) {
        if text.count > maxLabelCount {
            let limitedLabel = String(text.prefix(maxLabelCount))
            resultLabel.text = limitedLabel
        } else {
            resultLabel.text = text
        }
    }
    
    // MARK: - 버튼 배열을 StackView에 넣고 버튼 설정 하는 함수

    func makeHorizontalStackView(_ titles: [String]) -> UIStackView {
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
        guard let buttonTitle = sender.currentTitle else { return }
        buttonTapHandler?(buttonTitle)
    }
}
