//
//  CalculatorView.swift
//  TS_AppCalculator
//
//  Created by siyeon park on 11/14/24.
//

import UIKit

final class CalculatorView: UIView {
    weak var delegate: ButtonTypeDelegate?
    private var tagIndex = 0
    private let maxLabelCount = 18
    
    private let labelView: UIView = {
        let labelView = UIView()
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.backgroundColor = .clear
        return labelView
    }()
    
    lazy var displayLabel: UILabel = {
        let displayLabel = UILabel()
        displayLabel.translatesAutoresizingMaskIntoConstraints = false
        displayLabel.textAlignment = .right
        displayLabel.font = .systemFont(ofSize: 60, weight: .bold)
        displayLabel.textColor = .white
        displayLabel.adjustsFontSizeToFitWidth = true  // label이 화면너비만큼 입력시 폰트 사이즈 작아지도록 설정
        displayLabel.minimumScaleFactor = 0.5          // label 50%까지 줄어들 수 있도록 설정
        return displayLabel
    }()
    
    private let verticalStackView: UIStackView = {
        let verticalStackView = UIStackView()
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .equalSpacing
        
        // TODO: - screen의 비율로 넣으면 UI가 깨집니다 ㅠ 임의로 넣었는데 계속 고민해볼게요!
        verticalStackView.spacing = 10
        
        return verticalStackView
    }()
        
    private let buttonList: [[Enum.ButtonType]] = [
        [.seven, .eight, .nine, .plus],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .multiplication],
        [.ac, .zero, .equalSign, .division]
    ]
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 계산기 입력 숫자 제한 함수

    func limitedString(_ text: String) {
        if text.count > maxLabelCount {
            let limitedLabel = String(text.prefix(maxLabelCount))
            displayLabel.text = limitedLabel
        } else {
            displayLabel.text = text
        }
    }
}

private extension CalculatorView {
    func setupUI() {
        self.backgroundColor = .black
        
        // buttonList를 한줄씩 담는곳
        for (rowIndex, row) in buttonList.enumerated() {
            let buttonHorizontalStack = makeHorizontalStackView(row, rowIndex: rowIndex)
            verticalStackView.addArrangedSubview(buttonHorizontalStack)
        }
    }
    
    func setupConstraint() {
        addSubviews([labelView, verticalStackView])
        labelView.addSubview(displayLabel)
        
        let screenHeight = UIScreen.main.bounds.height
        
        NSLayoutConstraint.activate([
            labelView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: screenHeight * 0.2),
            labelView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            labelView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            labelView.heightAnchor.constraint(equalToConstant: 100),
            
            displayLabel.leadingAnchor.constraint(equalTo: labelView.leadingAnchor, constant: 30),
            displayLabel.trailingAnchor.constraint(equalTo: labelView.trailingAnchor, constant: -30),
            displayLabel.centerYAnchor.constraint(equalTo: labelView.centerYAnchor),

            verticalStackView.topAnchor.constraint(greaterThanOrEqualTo: labelView.bottomAnchor, constant: 60),
            verticalStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            verticalStackView.leadingAnchor.constraint(equalTo: displayLabel.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: displayLabel.trailingAnchor)
        ])
    }
    
    // MARK: - 버튼 배열을 StackView에 넣고 버튼 설정 하는 함수

    func makeHorizontalStackView(_ buttonTitles: [Enum.ButtonType], rowIndex: Int) -> UIStackView {
        var buttons: [UIButton] = []
        let screenWidth = UIScreen.main.bounds.width
        print("screenWidth \(screenWidth)")
        
        // 각 버튼의 title을 설정
        for (index, buttonType) in buttonTitles.enumerated() {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle(buttonType.rawValue, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 30)
            button.backgroundColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
            let globalTag = (rowIndex * buttonTitles.count) + index
            button.tag = globalTag
            
            // TODO: - 작은화면기기로 빌드시 에러 수정 필요
            let buttonSize = screenWidth * 0.2
            print("buttonSize \(buttonSize)")
            button.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
            button.widthAnchor.constraint(equalTo: button.heightAnchor).isActive = true
            button.layer.cornerRadius = buttonSize / 2

            if buttonType == .plus || buttonType == .minus || buttonType == .multiplication || buttonType == .division || buttonType == .ac || buttonType == .equalSign {
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
        horizontalStackView.spacing = screenWidth * 0.02
        
        return horizontalStackView
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        let flatButtonList = buttonList.flatMap { $0 }
        let buttonType = flatButtonList[sender.tag]
        print("Button tapped: \(buttonType), with tag: \(sender.tag)")
        delegate?.didTapButton(for: buttonType)
    }
}
