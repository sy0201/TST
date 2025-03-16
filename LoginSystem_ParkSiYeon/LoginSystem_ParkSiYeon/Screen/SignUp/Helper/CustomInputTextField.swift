//
//  CustomInputTextField.swift
//  LoginSystem_ParkSiYeon
//
//  Created by siyeon park on 3/14/25.
//

import UIKit
import SnapKit

final class CustomInputTextField: UITextField {
    private let inputType: InputType
    
    init(inputType: InputType) {
        self.inputType = inputType
        super.init(frame: .zero)
        setupUI()
        configureInputType()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func validateInput(_ confirmPassword: String? = nil) -> Bool {
        guard let text = self.text else {
            return false
        }
        
        return inputType.isValidInput(text, confirmPassword: confirmPassword)
    }
}

// MARK: - Private setupUI Method

private extension CustomInputTextField {
    func setupUI() {
        self.placeholder = inputType.placeholder
        self.borderStyle = .roundedRect
        self.font = .systemFont(ofSize: 14)
        self.clearButtonMode = .whileEditing
        self.autocorrectionType = .no
        
        // 비밀번호 입력 필드에서 눈 모양 버튼 추가
        if inputType == .password || inputType == .confirmPassword {
            let eyeButton = UIButton(type: .custom)
            eyeButton.tintColor = .borderGray
            //eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)  // 눈 아이콘 설정
            //eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .selected)  // 선택 시 눈 감기 아이콘 설정
            eyeButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
            
            // UIButtonConfiguration 사용하여 스타일 설정
            var configuration = UIButton.Configuration.plain()
            configuration.image = UIImage(systemName: "eye")
            configuration.imagePadding = 10 // 오른쪽 여백 설정
            configuration.background = .clear() // 배경을 투명하게 설정
            configuration.baseBackgroundColor = .clear // 눌렸을 때도 배경이 보이지 않도록 설정
            eyeButton.configuration = configuration
            
            rightView = eyeButton
            rightViewMode = .always
        }
    }
    
    // 비밀번호 보이기/숨기기 기능 구현
    @objc func togglePasswordVisibility() {
        isSecureTextEntry.toggle()
        
        // 버튼의 이미지 변경
        if let eyeButton = rightView as? UIButton {
            eyeButton.isSelected = !isSecureTextEntry
            eyeButton.configuration?.image = isSecureTextEntry ? UIImage(systemName: "eye") : UIImage(systemName: "eye.slash")
        }
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
}
