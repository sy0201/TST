//
//  ContactViewModel.swift
//  TS_PoketmonContact
//
//  Created by siyeon park on 12/10/24.
//

import UIKit

final class ContactViewModel {
    let contactDataManager = ContactDataManager.shared
    private(set) var contactList: [ContactEntity] = []     // contactList 외부에서 읽기만 가능, set은 해당 class에서만 가능

    
    func loadContacts() {
        self.contactList = contactDataManager.readContactData()
    }
    
    func addContact(name: String, phoneNumber: String, profileImage: String) {
        contactDataManager.createContactData(name: name, phoneNumber: phoneNumber, profileImage: profileImage)
        loadContacts()
    }
    
    func updateContact(contact: ContactEntity, name: String, phoneNumber: String, profileImage: String) {
        contactDataManager.updateContactData(contact: contact, name: name, phoneNumber: phoneNumber, profileImage: profileImage)
        loadContacts() // 연락처 리스트 업데이트
    }
}
