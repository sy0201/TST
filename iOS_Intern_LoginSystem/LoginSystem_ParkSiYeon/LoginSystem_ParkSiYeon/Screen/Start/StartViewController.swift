//
//  StartViewController.swift
//  LoginSystem_ParkSiYeon
//
//  Created by siyeon park on 3/13/25.
//

import UIKit
import RxSwift

final class StartViewController: UIViewController {
    let startViewModel = StartViewModel()
    let disposeBag = DisposeBag()
    
    let startView = StartView()

    override func loadView() {
        super.loadView()
        view = startView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindStartViewModel()
    }
}

// MARK: - Private bindViewModel Method

private extension StartViewController {
    func bindStartViewModel() {
        startViewModel.startButtonTapped
            .subscribe(onNext: { [weak self] _ in
                // Login 정보 확인
                self?.checkLoginStatus()
            })
            .disposed(by: disposeBag)
        
        startView.startButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.startViewModel.handleStartButtonTap()
            })
            .disposed(by: disposeBag)
        
        startViewModel.loginStatus
            .subscribe(onNext: { [weak self] loggedIn in
                self?.loginStatus(loggedIn: loggedIn)
            })
            .disposed(by: disposeBag)
    }
    
    func checkLoginStatus() {
        startViewModel.updateLoginStatus()
    }
    
    func loginStatus(loggedIn: Bool) {
        if loggedIn {
            // 로그인 정보가 있다면 로그인 화면으로 이동
            self.pushToLoginView()
        } else {
            // 로그인 정보가 없다면 회원가입 화면으로 이동
            self.pushToSignUpView()
        }
    }
    
    func pushToLoginView() {
        let successViewController = LoginSuccessViewController()
        setRootViewController(successViewController)
    }
    
    func pushToSignUpView() {
        let signUpViewController = SignUpViewController()
        setRootViewController(signUpViewController)
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
