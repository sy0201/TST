//
//  SignUpViewController.swift
//  LoginSystem_ParkSiYeon
//
//  Created by siyeon park on 3/14/25.
//

import UIKit

final class SignUpViewController: UIViewController {
    let signUpViewModel = SignUpViewModel()
    
    let signUpView = SignUpView()

    override func loadView() {
        super.loadView()
        view = signUpView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpView.bindViewModel(viewModel: signUpViewModel)
    }
}
