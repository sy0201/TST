//
//  SignUpViewController.swift
//  LoginSystem_ParkSiYeon
//
//  Created by siyeon park on 3/14/25.
//

import UIKit
import RxSwift

final class SignUpViewController: UIViewController {
    let signUpViewModel = SignUpViewModel()
    let disposeBag = DisposeBag()
    
    let signUpView = SignUpView()

    override func loadView() {
        super.loadView()
        view = signUpView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpView.bindViewModel(viewModel: signUpViewModel)
        bindSignUpViewModel()
    }
}

// MARK: - Private Extension Methods

private extension SignUpViewController {
    func bindSignUpViewModel() {
        // 회원가입 버튼 액션 바인딩
        signUpView.signUpButton.rx.tap
            .bind { [weak self] in
                self?.handleSignUp()
            }
            .disposed(by: disposeBag)
        
        // 회원가입 성공 여부에 따라 화면 전환
        signUpViewModel.signUpSuccess
            .subscribe(onNext: { [weak self] success in
                if success {
                    // 성공하면 로그인 화면으로 이동
                    self?.navigateToLogin()
                } else {
                    // 이메일 중복 시 에러 처리
                    self?.showEmailAlreadyExistsError()
                }
            })
            .disposed(by: disposeBag)
    }
    
    func handleSignUp() {
        // 회원가입 시도
        signUpViewModel.signUp()
    }
    
    func navigateToLogin() {
        // 로그인 화면으로 이동
        let loginViewController = LoginViewController()
        setRootViewController(loginViewController)
    }
    
    func setRootViewController(_ viewController: UIViewController) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }
        
        guard let window = windowScene.windows.first else {
            return
        }
        
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
            window.rootViewController = viewController
        }, completion: { _ in
            window.makeKeyAndVisible()
        })
    }
    
    func showEmailAlreadyExistsError() {
        let alert = UIAlertController(title: "이미 존재하는 이메일", message: "입력한 이메일은 이미 등록된 이메일입니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
