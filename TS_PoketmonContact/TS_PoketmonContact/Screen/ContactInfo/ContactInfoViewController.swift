//
//  ContactInfoViewController.swift
//  TS_PoketmonContact
//
//  Created by siyeon park on 12/8/24.
//

import UIKit

final class ContactInfoViewController: UIViewController {
    let pokemonViewModel = PokemonViewModel(repository: PokemonRepository(networkService: NetworkService()))
    let contactViewModel: ContactViewModel
    let contactInfoView = ContactInfoView()
    
    init(contactViewModel: ContactViewModel) {
        self.contactViewModel = contactViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        super.loadView()
        view = contactInfoView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupRandomPokemon()
    }
    
    func setupNavigationBar() {
        // 오른쪽 바 버튼 설정
        let navRightItem = UIBarButtonItem(title: "적용",
                                           style: .plain,
                                           target: self,
                                           action: #selector(applyButtonTapped))
        navigationItem.rightBarButtonItem = navRightItem
        navigationItem.title = "연락처 추가"
    }

    @objc func applyButtonTapped() {
        guard let name = contactInfoView.nameTextField.text,
              let phoneNumber = contactInfoView.phoneTextField.text,
              let profileImage = pokemonViewModel.getPokemonImageURL() else {
            print("유효하지 않은 입력입니다.")
            return
        }
        
        contactViewModel.addContact(name: name, phoneNumber: phoneNumber, profileImage: profileImage)
        navigationController?.popViewController(animated: true)
    }
    
    func setupRandomPokemon() {
        contactInfoView.randomButton.addTarget(self, action: #selector(randomImage), for: .touchUpInside)
    }
    
    @objc func randomImage() {
        // 포켓몬 데이터 가져오기
        pokemonViewModel.fetchRandomPokemon()
        pokemonViewModel.onPokemonData = { [weak self] in
            if let imageURL = self?.pokemonViewModel.getPokemonImageURL() {
                self?.contactInfoView.profileImg.loadImage(from: imageURL)
            } else {
                print("이미지가 없습니다.")
            }
        }
    }
}
