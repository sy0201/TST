//
//  LoginViewController.swift
//  LoginSystem_ParkSiYeon
//
//  Created by siyeon park on 3/14/25.
//

import UIKit
import RxSwift

final class LoginViewController: UIViewController {
    let loginViewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    let loginView = LoginView()

    override func loadView() {
        super.loadView()
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindLoginViewModel()
    }
}

// MARK: - Private Extension Methods

private extension LoginViewController {
    func bindLoginViewModel() {
        // 로그아웃 버튼 액션 바인딩
        loginView.logoutButton.rx.tap
            .bind { [weak self] in
                self?.loginViewModel.logout()
            }
            .disposed(by: disposeBag)
        
        // 회원탈퇴 버튼 액션 바인딩
        loginView.withdrawButton.rx.tap
            .bind { [weak self] in
                self?.loginViewModel.withdraw()
            }
            .disposed(by: disposeBag)
        
        // ViewModel의 상태 변화 감지
        loginViewModel.logoutSuccess
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.navigateToStartScreen()
            })
            .disposed(by: disposeBag)
        
        loginViewModel.withdrawSuccess
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.navigateToStartScreen()
            })
            .disposed(by: disposeBag)
        
        loginViewModel.nickname
            .observe(on: MainScheduler.instance) // 메인 스레드에서 UI 업데이트
            .bind { [weak self] nickname in
                self?.loginView.nicknameLabel.text = "\(nickname)"
            }
            .disposed(by: disposeBag)
    }
    
    func navigateToStartScreen() {
        let startViewController = StartViewController()
        setRootViewController(startViewController)
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
}
