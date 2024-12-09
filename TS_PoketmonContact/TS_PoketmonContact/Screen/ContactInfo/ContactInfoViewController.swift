//
//  ContactInfoViewController.swift
//  TS_PoketmonContact
//
//  Created by siyeon park on 12/8/24.
//

import UIKit
import Kingfisher

final class ContactInfoViewController: UIViewController {
    let pokemonViewModel = PokemonViewModel(repository: PokemonRepository(networkService: NetworkService()))
    let contactInfoView = ContactInfoView()

    
    override func loadView() {
        super.loadView()
        view = contactInfoView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setRandomPokemon()
    }
    
    func setupNavigationBar() {
        // 오른쪽 바 버튼 설정
        let navRightItem = UIBarButtonItem(title: "적용",
                                           style: .plain,
                                           target: self,
                                           action: #selector(confirmButtonTapped))
        navigationItem.rightBarButtonItem = navRightItem
        navigationItem.title = "연락처 추가"
    }

    @objc func confirmButtonTapped() {
    }
    
    func setRandomPokemon() {
        // 포켓몬 데이터 가져오기
        pokemonViewModel.fetchRandomPokemon()
        
        pokemonViewModel.onPokemonData = { [weak self] in
            if let randomImgURL = self?.pokemonViewModel.getPokemonResponse()?.sprites.frontDefault {
                self?.loadImage(from: randomImgURL)
            }
        }
        
        contactInfoView.randomButton.addTarget(self, action: #selector(randomImage), for: .touchUpInside)
    }
    
    @objc func randomImage() {
        if let randomImgURL = pokemonViewModel.getPokemonResponse()?.sprites.frontDefault {
            loadImage(from: randomImgURL)
        } else {
            print("이미지가 없습니다.")
        }
    }
    
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        contactInfoView.profileImg.kf.setImage(with: url)
    }
}
