//
//  ContactViewModel.swift
//  TS_PoketmonContact
//
//  Created by siyeon park on 12/10/24.
//

import UIKit

final class ContactViewModel {
    let contactDataManager = ContactDataManager.shared
    private(set) var contactList: [ContactEntity] = []  // contactList 외부에서 읽기만 가능, set은 해당 class에서만 가능
    
    func sortContactsByName() {
        contactList.sort { ($0.name ?? "") < ($1.name ?? "") }
    }
    
    func loadContacts() {
        self.contactList = contactDataManager.readContactData()
        sortContactsByName()
    }
    
    func addContact(name: String, phoneNumber: String, profileImage: String) {
        contactDataManager.createContactData(name: name, phoneNumber: phoneNumber, profileImage: profileImage)
        loadContacts()
    }
    
    func updateContact(contact: ContactEntity, name: String, phoneNumber: String, profileImage: String?) {
        let updatedImageURL: String
        if let profileImage = profileImage, !profileImage.isEmpty {
            updatedImageURL = profileImage // 새로운 이미지 URL이 있을 경우
        } else {
            updatedImageURL = contact.profileImage ?? "default_image_url" // 기존 이미지 URL이 없으면 기본 이미지 사용
        }
        
        contactDataManager.updateContactData(contact: contact, name: name, phoneNumber: phoneNumber, profileImage: updatedImageURL)
        loadContacts()
    }
    
    func deleteContact(contact: ContactEntity) {
        contactDataManager.deleteContactData(name: contact.name ?? "")
        loadContacts()
    }
}
