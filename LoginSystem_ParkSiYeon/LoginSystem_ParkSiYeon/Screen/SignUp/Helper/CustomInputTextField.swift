//
//  CustomInputTextField.swift
//  LoginSystem_ParkSiYeon
//
//  Created by siyeon park on 3/14/25.
//

import UIKit

final class CustomInputTextField: UITextField {
    private let inputType: InputType
    
    init(inputType: InputType, placeholder: String) {
        self.inputType = inputType
        super.init(frame: .zero)
        setupUI(placeholder: placeholder)
        configureInputType()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func validateInput() -> Bool {
        guard let text = self.text else {
            return false
        }
        
        switch inputType {
        case .email:
            return isValidateEmail(text)
            
        case .password, .confirmPassword:
            return 8 <= text.count

        case .nickname:
            return 1 <= text.count
        }
    }
}

// MARK: - Private setupUI Method

private extension CustomInputTextField {
    func setupUI(placeholder: String) {
        self.placeholder = placeholder
        self.borderStyle = .roundedRect
        self.font = .systemFont(ofSize: 14)
        self.clearButtonMode = .whileEditing
        self.autocorrectionType = .no
    }
    
    func configureInputType() {
        switch inputType {
        case .email:
            keyboardType = .emailAddress
            isSecureTextEntry = false
            
        case .password, .confirmPassword:
            keyboardType = .default
            textContentType = .oneTimeCode
            isSecureTextEntry = true
            
        case .nickname:
            keyboardType = .default
            isSecureTextEntry = false
        }
    }
    
    func isValidateEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}
