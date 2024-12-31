//
//  DetailViewController.swift
//  TS_PokeRxMVVM
//
//  Created by t2023-m0019 on 12/31/24.
//

import UIKit
import RxSwift

final class DetailViewController: UIViewController {
    private let viewModel: PokeViewModel
    private let disposebag = DisposeBag()
    
    let detailView = DetailView()

    init(viewModel: PokeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
}

// MARK: - bind Method
private extension DetailViewController {
    func bindViewModel() {
        viewModel.pokeDetail
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] detail in
                self?.detailView.configure(with: detail)
            })
            .disposed(by: disposebag)
    }
}
