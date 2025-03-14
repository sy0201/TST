//
//  StartViewModel.swift
//  LoginSystem_ParkSiYeon
//
//  Created by siyeon park on 3/14/25.
//

import RxCocoa

final class StartViewModel {
    let startButtonTapped = PublishRelay<Void>()
    
    func handleStartButtonTap() {
        startButtonTapped.accept(())
    }
}
