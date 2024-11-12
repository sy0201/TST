//
//  CalculatorViewController.swift
//  CalculatorApp
//
//  Created by siyeon park on 11/11/24.
//

import UIKit

final class CalculatorViewController: UIViewController {
    private let maxLabelCharacters = 19
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 60, weight: .bold)
        label.textColor = .white
        label.text = "1,23"
        label.adjustsFontSizeToFitWidth = true  // 텍스트가 화면너비에 맞게 자동 축소 설정
        label.minimumScaleFactor = 0.5  // 폰트 크기가 최대 50%까지 줄어들 수 있도록 설정
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupConstraint()
    }
    
    private func setupConstraint() {
        view.addSubview(resultLabel)
        
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            resultLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
