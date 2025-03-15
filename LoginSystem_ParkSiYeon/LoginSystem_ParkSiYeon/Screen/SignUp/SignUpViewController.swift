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
        let loginViewController = LoginViewController() // 로그인 화면으로 바꿔주세요
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    func showEmailAlreadyExistsError() {
        let alert = UIAlertController(title: "이미 존재하는 이메일", message: "입력한 이메일은 이미 등록된 이메일입니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
