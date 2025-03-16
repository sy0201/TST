//
//  CustomInputView.swift
//  LoginSystem_ParkSiYeon
//
//  Created by siyeon park on 3/14/25.
//

import UIKit
import SnapKit

final class CustomInputView: UIView {
    private let inputType: InputType
    private let baseView = UIView()
    
    private let textField: CustomInputTextField
    private let errorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.font = .systemFont(ofSize: 12, weight: .regular)
        errorLabel.textColor = .red
        errorLabel.isHidden = true
        return errorLabel
    }()
    
    init(inputType: InputType) {
        self.inputType = inputType
        self.textField = CustomInputTextField(inputType: inputType)
        super.init(frame: .zero)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var inputTextField: CustomInputTextField {
        return textField
    }
    
    func validateInput(confirmPassword: String? = nil) {
        guard let text = textField.text, !text.isEmpty else {
            errorLabel.isHidden = true
            return
        }
        
        // 유효성 검사
        let isValid: Bool
        
        if let confirmPassword = confirmPassword, inputType == .confirmPassword {
            // confirmPassword일 경우 password와 비교
            isValid = text == confirmPassword
        } else {
            isValid = inputType.isValidInput(text, confirmPassword: confirmPassword)
        }
        
        errorLabel.text = isValid ? nil : inputType.errorMessage
        errorLabel.isHidden = isValid
    }
}

// MARK: - Private setupUI Method

private extension CustomInputView {
    func setupUI() {
        addSubViews([baseView, textField, errorLabel])
    }
    
    func setupConstraint() {
        baseView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(baseView)
            make.height.equalTo(44)
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(baseView.snp.bottom)
        }
    }
}
