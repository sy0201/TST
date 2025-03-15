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
    private let errorText: UILabel = {
        let errorText = UILabel()
        errorText.font = .systemFont(ofSize: 12, weight: .regular)
        errorText.textColor = .red
        errorText.isHidden = true
        return errorText
    }()
    
    init(inputType: InputType, placeholder: String) {
        self.inputType = inputType
        self.textField = CustomInputTextField(inputType: inputType, placeholder: placeholder)
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
}

// MARK: - Private setupUI Method

private extension CustomInputView {
    func setupUI() {
        addSubViews([baseView, textField, errorText])
    }
    
    func setupConstraint() {
        baseView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(baseView)
            make.height.equalTo(44)
        }
        
        errorText.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(16)
            make.bottom.equalToSuperview()
        }
    }
}
