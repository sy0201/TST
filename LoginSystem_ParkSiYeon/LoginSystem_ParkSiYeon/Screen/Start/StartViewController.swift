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

// MARK: - Private setupUI Method

private extension StartViewController {
    func bindStartViewModel() {
        startViewModel.startButtonTapped
            .subscribe(onNext: { [weak self] _ in
                // Login 정보 확인
                self?.pushToLoginView()
            })
            .disposed(by: disposeBag)
        
        startView.startButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.startViewModel.handleStartButtonTap()
            })
            .disposed(by: disposeBag)
    }
    
    func pushToLoginView() {
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
        
        // 애니메이션을 추가하여 화면 전환
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
            window.rootViewController = viewController
        }, completion: { _ in
            window.makeKeyAndVisible()
        })
    }
}
