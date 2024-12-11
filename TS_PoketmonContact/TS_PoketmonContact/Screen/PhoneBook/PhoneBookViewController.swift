//
//  ContactInfoViewController.swift
//  TS_PoketmonContact
//
//  Created by siyeon park on 12/8/24.
//

import UIKit

final class PhoneBookViewController: UIViewController {
    let pokemonViewModel = PokemonViewModel(repository: PokemonRepository(networkService: NetworkService()))
    let contactViewModel: ContactViewModel
    var selectedContact: ContactEntity?
    let phoneBookView = PhoneBookView()
    
    init(contactViewModel: ContactViewModel, selectedContact: ContactEntity? = nil) {
        self.contactViewModel = contactViewModel
        self.selectedContact = selectedContact
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        super.loadView()
        view = phoneBookView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupRandomPokemon()
        
        if let contact = selectedContact {
            phoneBookView.nameTextField.text = contact.name
            phoneBookView.phoneTextField.text = contact.phoneNumber
            if let imageString = contact.profileImage {
                phoneBookView.profileImg.loadImage(from: imageString)
            }
        }
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
        guard let name = phoneBookView.nameTextField.text,
              let phoneNumber = phoneBookView.phoneTextField.text,
              let profileImage = pokemonViewModel.getPokemonImageURL() else {
            print("유효하지 않은 입력입니다.")
            return
        }

        if let contact = selectedContact {
            // 기존 데이터가 있으면 업데이트(수정)
            print("name: \(name), phoneNumber: \(phoneNumber), profileImage: \(profileImage)")
            contactViewModel.updateContact(contact: contact, name: name, phoneNumber: phoneNumber, profileImage: profileImage)
        } else {
            print("name: \(name), phoneNumber: \(phoneNumber), profileImage: \(profileImage)")
            // 기존 데이터가 없으면 새로 저장
            contactViewModel.addContact(name: name, phoneNumber: phoneNumber, profileImage: profileImage)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func setupRandomPokemon() {
        phoneBookView.randomButton.addTarget(self, action: #selector(getRandomImage), for: .touchUpInside)
    }
    
    @objc func getRandomImage() {
        // 포켓몬 데이터 가져오기
        pokemonViewModel.fetchRandomPokemon()
        pokemonViewModel.onPokemonData = { [weak self] in
            if let imageURL = self?.pokemonViewModel.getPokemonImageURL() {
                self?.phoneBookView.profileImg.loadImage(from: imageURL)
            } else {
                print("이미지가 없습니다.")
            }
        }
    }
}
