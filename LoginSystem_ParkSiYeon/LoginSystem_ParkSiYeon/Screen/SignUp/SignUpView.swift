//
//  SignUpView.swift
//  LoginSystem_ParkSiYeon
//
//  Created by siyeon park on 3/14/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SignUpView: UIView {
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    private let baseView = UIView()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private let emailView = CustomInputView(inputType: .email, placeholder: "이메일을 입력해주세요.")
    private let passwordView = CustomInputView(inputType: .password, placeholder: "비밀번호를 입력해주세요.")
    private let confirmPasswordView = CustomInputView(inputType: .confirmPassword, placeholder: "비밀번호를 확인해주세요.")
    private let nicknameView = CustomInputView(inputType: .nickname, placeholder: "닉네임을 입력해주세요.")
    
    var signUpButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.primaryDarkGray, for: .normal)
        button.backgroundColor = .backgroundLightGray
        
        return button
    }()

    private let disposeBag = DisposeBag()

    var keyboardHeight: Observable<CGFloat> {
        return Observable
            .from([
                NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
                    .map { notification -> CGFloat in
                        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
                        return keyboardFrame?.height ?? 0
                    },
                NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
                    .map { _ in CGFloat(0) }
            ])
            .merge()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
        bindKeyboard()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private setupUI Method

private extension SignUpView {
    func setupUI() {
        self.backgroundColor = .white
        baseView.backgroundColor = .white
        
        addSubview(scrollView)
        scrollView.addSubview(baseView)
        baseView.addSubViews([verticalStackView, signUpButton])
        
        verticalStackView.addArrangedSubViews([emailView,
                                               passwordView,
                                               confirmPasswordView,
                                               nicknameView])
    }
    
    func setupConstraint() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        baseView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        emailView.snp.makeConstraints { make in
            make.height.equalTo(64)
        }
        
        passwordView.snp.makeConstraints { make in
            make.height.equalTo(64)
        }
        
        confirmPasswordView.snp.makeConstraints { make in
            make.height.equalTo(64)
        }
        
        nicknameView.snp.makeConstraints { make in
            make.height.equalTo(64)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(verticalStackView.snp.bottom).offset(20)
            make.bottom.equalToSuperview().inset(20)
            make.leading.trailing.equalTo(baseView).inset(20)
            make.height.equalTo(60)
        }
    }
    
    func bindKeyboard() {
        keyboardHeight
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] height in
                guard let self = self else { return }
                let additionalPadding: CGFloat = 20
                self.scrollView.contentInset.bottom = height + additionalPadding
                self.scrollView.verticalScrollIndicatorInsets.bottom = height
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - bindViewModel Method

extension SignUpView {
    func bindViewModel(viewModel: SignUpViewModel) {
        // emailTextField와 viewModel의 email을 바인딩
        emailView.inputTextField.rx.text.orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        // passwordTextField와 viewModel의 password를 바인딩
        passwordView.inputTextField.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        // confirmPasswordTextField와 viewModel의 confirmPassword를 바인딩
        confirmPasswordView.inputTextField.rx.text.orEmpty
            .bind(to: viewModel.confirmPassword)
            .disposed(by: disposeBag)
        
        // nicknameTextField와 viewModel의 nickname을 바인딩
        nicknameView.inputTextField.rx.text.orEmpty
            .bind(to: viewModel.nickname)
            .disposed(by: disposeBag)
        
        // SignUp 버튼 활성화/비활성화 바인딩
        viewModel.signUpEnabled
            .bind(to: signUpButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}
