//
//  ContactInfoViewController.swift
//  TS_PoketmonContact
//
//  Created by siyeon park on 12/8/24.
//

import UIKit

enum PhoneBookMode {
    case add
    case edit
}

final class PhoneBookViewController: UIViewController {
    let pokemonViewModel = PokemonViewModel(repository: PokemonRepository(networkService: NetworkService()))
    let contactViewModel: ContactViewModel
    var selectedContact: ContactEntity?
    let mode: PhoneBookMode
    let phoneBookView = PhoneBookView()
    
    init(contactViewModel: ContactViewModel, selectedContact: ContactEntity? = nil, mode: PhoneBookMode) {
        self.contactViewModel = contactViewModel
        self.selectedContact = selectedContact
        self.mode = mode
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
        checkNetworkStatus()
        setupNavigationBar()
        setupTextField()
        setupRandomPokemon()
        
        // 기존 연락처 정보를 수정시 텍스트 필드에 값 설정
        if let contact = selectedContact {
            print("Selected Contact Profile Image: \(contact.profileImage ?? "nil")")
            phoneBookView.nameTextField.text = contact.name
            phoneBookView.phoneTextField.text = contact.phoneNumber
            if let imageString = contact.profileImage, !imageString.isEmpty {
                phoneBookView.profileImg.loadImage(from: imageString)
            } else {
                phoneBookView.profileImg.image = UIImage(named: "placeholder")
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
        
        if mode == .edit {
            navigationItem.title = selectedContact?.name
        } else {
            navigationItem.title = "연락처 추가"
        }
    }
    
    func setupTextField() {
        phoneBookView.nameTextField.delegate = self
        phoneBookView.phoneTextField.delegate = self
    }

    @objc func applyButtonTapped() {
        let name = phoneBookView.nameTextField.text
        let phoneNumber = phoneBookView.phoneTextField.text
        let profileImage = pokemonViewModel.getPokemonImageURL() ?? "default_image_url"  // 기본값 설정
        
        guard let name = name, !name.isEmpty,
              let phoneNumber = phoneNumber, !phoneNumber.isEmpty else {
            print("유효하지 않은 입력입니다.")
            validInputAlert(title: "입력 오류", message: "모든 항목을 입력해주세요.")
            return
        }
        
        if let contact = selectedContact {
            contactViewModel.updateContact(contact: contact, name: name, phoneNumber: phoneNumber, profileImage: profileImage)
        } else {
            contactViewModel.addContact(name: name, phoneNumber: phoneNumber, profileImage: profileImage)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func checkNetworkStatus() {
        if NetworkMonitor.shared.isConnected {
            print("인터넷 연결완료")
        } else {
            print("인터넷 연결실패")
            checkNetworkAlert()
        }
    }
    
    func checkNetworkAlert() {
        let alertController = UIAlertController(
            title: "네트워크에 접속할 수 없습니다.",
            message: "네트워크 연결 상태를 확인해주세요.",
            preferredStyle: .alert
        )
        
        let endAction = UIAlertAction(title: "종료", style: .destructive) { _ in
            // 앱 종료
            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                exit(0)
            }
        }
        
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
            // 설정앱 켜주기
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        
        alertController.addAction(endAction)
        alertController.addAction(confirmAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func validInputAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default)
        alertController.addAction(confirmAction)
        self.present(alertController, animated: true, completion: nil)
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
                print("imageURL \(imageURL)")
            } else {
                print("이미지가 없습니다.")
            }
        }
    }
}

// MARK: - UITextFieldDelegate Method

extension PhoneBookViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 현재 텍스트 필드에 있는 텍스트
        let currentText = textField.text ?? ""
        
        // 입력 후 결과 텍스트
        guard let textRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: textRange, with: string)
        
        // 11자리 초과 입력 방지
        if updatedText.count > 13 {
            return false
        }
        
        // 전화번호 입력 필드에 대한 처리
        if textField == phoneBookView.phoneTextField {
            // 숫자만 입력 가능
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            if !allowedCharacters.isSuperset(of: characterSet) {
                return false
            }
            
            // 자동으로 "-" 추가
            textField.text = formatPhoneNumber(updatedText)
            return false // 직접 textField.text를 업데이트했으므로 반환 false
        }
        
        // 다른 텍스트 필드는 기본 처리
        return true
    }
    
    /// 전화번호 형식으로 변환
    private func formatPhoneNumber(_ number: String) -> String {
        let digits = number.filter { $0.isNumber } // 숫자만 남기기
        var formattedNumber = digits
        
        if digits.count > 3 {
            formattedNumber.insert("-", at: formattedNumber.index(formattedNumber.startIndex, offsetBy: 3))
        }
        if digits.count > 7 {
            formattedNumber.insert("-", at: formattedNumber.index(formattedNumber.startIndex, offsetBy: 8))
        }
        
        return formattedNumber
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 키보드 숨기기
        textField.resignFirstResponder()
        return true
    }
}
