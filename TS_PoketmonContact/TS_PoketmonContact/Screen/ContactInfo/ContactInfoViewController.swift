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
    let contactViewModel = ContactViewModel(contactList: [])
    let contactInfoView = ContactInfoView()

    
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
        print("적용버튼")
        guard let name = contactInfoView.nameTextField.text,
              let phoneNumber = contactInfoView.phoneTextField.text,
              let profileImg = contactInfoView.profileImg.image else {
            return
        }
        
        // 이미지 URL String으로 변환
        let imageString = contactViewModel.saveImageToString(image: profileImg)
        
        contactViewModel.contactDataManager.createContactData(name: name, phoneNumber: phoneNumber, profileImage: imageString)
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupRandomPokemon() {
        contactInfoView.randomButton.addTarget(self, action: #selector(randomImage), for: .touchUpInside)
    }
    
    private func saveImageToLocalDirectory(image: UIImage) -> String {
        guard let data = image.pngData() else { return "" }
        let fileName = UUID().uuidString + ".png"
        let filePath = NSTemporaryDirectory().appending(fileName)
        let fileURL = URL(fileURLWithPath: filePath)
        do {
            try data.write(to: fileURL)
            UserDefaults.standard.set(fileURL.path, forKey: "lastSavedImagePath")
            return fileURL.path
        } catch {
            print("이미지 저장 실패: \(error.localizedDescription)")
            return ""
        }
    }
    
    @objc func randomImage() {
        // 포켓몬 데이터 가져오기
        pokemonViewModel.fetchRandomPokemon()
        
        pokemonViewModel.onPokemonData = { [weak self] in
            if let randomImgString = self?.pokemonViewModel.getPokemonResponse()?.sprites.frontDefault {
                self?.loadImage(from: randomImgString)
            }else {
                print("이미지가 없습니다.")
            }
        }
    }
    
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        contactInfoView.profileImg.kf.setImage(with: url)
    }
}
