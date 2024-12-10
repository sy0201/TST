//
//  ContactViewModel.swift
//  TS_PoketmonContact
//
//  Created by siyeon park on 12/10/24.
//

import Kingfisher
import UIKit

final class ContactViewModel {
    let contactDataManager = ContactDataManager.shared
    var contactList: [ContactEntity]
    
    init(contactList: [ContactEntity]) {
        self.contactList = contactList
    }
    
    func getContactList() {
        self.contactList = contactDataManager.readContactData()
    }
    
    // png로 이미지 저장
    func saveImageToString(image: UIImage) -> String {
        guard let data = image.pngData() else { return "" }
        let fileName = UUID().uuidString + ".png"
        let filePath = NSTemporaryDirectory().appending(fileName)
        let fileURL = URL(fileURLWithPath: filePath)
        do {
            try data.write(to: fileURL)
            return fileURL.path
        } catch {
            print("이미지 저장 실패: \(error.localizedDescription)")
            return ""
        }
    }
    
    // 이미지 불러오기
    func loadImage(from filePath: String) -> UIImage? {
        let fileURL = URL(fileURLWithPath: filePath)
        return UIImage(contentsOfFile: fileURL.path)
    }
}
