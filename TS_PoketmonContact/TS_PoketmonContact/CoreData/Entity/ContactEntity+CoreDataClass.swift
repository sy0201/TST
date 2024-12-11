//
//  ContactEntity+CoreDataClass.swift
//  TS_PoketmonContact
//
//  Created by siyeon park on 12/10/24.
//
//

import Foundation
import CoreData

@objc(ContactEntity)
public class ContactEntity: NSManagedObject {
    public static let className = "ContactEntity"
    public enum Key {
        static let id = "id"
        static let name = "name"
        static let phoneNumber = "phoneNumber"
        static let profileImage = "profileImage"
    }
}
