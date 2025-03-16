//
//  StartViewModel.swift
//  LoginSystem_ParkSiYeon
//
//  Created by siyeon park on 3/14/25.
//

import RxCocoa

final class StartViewModel {
    private let userDefaultsManager = UserDefaultsManager.shared
    
    let startButtonTapped = PublishRelay<Void>()
    let loginStatus = BehaviorRelay<Bool>(value: false)
    
    init() {
        loginStatus.accept(userDefaultsManager.getUserLoggedIn())
    }
    
    func handleStartButtonTap() {
        startButtonTapped.accept(())
    }
    
    func updateLoginStatus() {
        loginStatus.accept(userDefaultsManager.getUserLoggedIn())
    }
}
