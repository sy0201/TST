//
//  ViewController.swift
//  TS_PokeRxMVVM
//
//  Created by t2023-m0019 on 12/31/24.
//

import UIKit
import RxSwift

final class MainViewController: UIViewController {
    private let viewModel: PokeViewModel
    private let disposebag = DisposeBag()
    
    init(viewModel: PokeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - bind Method

private extension MainViewController {
    func bindViewModel() {
    }
}
