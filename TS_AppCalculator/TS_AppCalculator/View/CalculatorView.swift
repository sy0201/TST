//
//  CalculatorView.swift
//  TS_AppCalculator
//
//  Created by siyeon park on 11/14/24.
//

import Foundation
import UIKit

final class CalculatorView: UIView {
    private let maxLabelCount = 17
    private let resultLabel = UILabel()
    
    let buttonList = [
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
        
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.textAlignment = .right
        resultLabel.font = .systemFont(ofSize: 60, weight: .bold)
        resultLabel.textColor = .white
        resultLabel.text = "1,234"
        resultLabel.adjustsFontSizeToFitWidth = true  // label이 화면너비만큼 입력시 폰트 사이즈 작아지도록 설정
        resultLabel.minimumScaleFactor = 0.5  // label 50%까지 줄어들 수 있도록 설정
        resultLabel.lineBreakMode = .byTruncatingTail
    }
    
    func setupConstraint() {
        addSubview(resultLabel)
        
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 200),
            resultLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            resultLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            resultLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func limitedString(_ text: String) {
        if text.count > maxLabelCount {
            let limitedLabel = String(text.prefix(maxLabelCount))
            resultLabel.text = limitedLabel
            print("limitedLabel\(limitedLabel)")
            print("limitedLabel\(limitedLabel.count)")
        } else {
            resultLabel.text = text
        }
    }
}
