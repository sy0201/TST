//
//  DetailViewController.swift
//  TS_PokeRxMVVM
//
//  Created by t2023-m0019 on 12/31/24.
//

import UIKit
import RxSwift

final class DetailViewController: UIViewController {
    private let viewModel: DetailViewModel
    private let disposebag = DisposeBag()
    
    let detailView = DetailView()

    init(viewModel: DetailViewModel) {
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
        viewModel.loadPokeDetail()
    }
}

// MARK: - bind Method
private extension DetailViewController {
    func bindViewModel() {
        viewModel.pokeDetail
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] detail in
                if let detail = detail {
                    self?.detailView.configure(with: detail)
                } else {
                    // detail이 nil인 경우 처리 (예: 에러 메시지 표시, 기본값 설정 등)
                    self?.showNoNetworkAlert()
                    print("PokeDetail is nil.")
                }
                
                // Hide loading indicator once the data is loaded
                LoadingIndicator.hideLoading()
            })
            .disposed(by: disposebag)
    }
    
    // 네트워크가 없을 때 사용자에게 알림을 표시하는 함수
    func showNoNetworkAlert() {
        let alert = UIAlertController(title: "네트워크가 없습니다.", message: "네트워크 연결을 다시 시도하시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
