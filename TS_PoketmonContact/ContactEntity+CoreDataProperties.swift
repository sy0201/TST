//
//  ContactEntity+CoreDataProperties.swift
//  TS_PoketmonContact
//
//  Created by siyeon park on 12/10/24.
//
//

import Foundation
import CoreData


extension ContactEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ContactEntity> {
        return NSFetchRequest<ContactEntity>(entityName: "ContactEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var id: UUID?
    @NSManaged public var profileImage: String?

}

extension ContactEntity : Identifiable {

}
