//
//  ContactDataManager.swift
//  TS_PoketmonContact
//
//  Created by siyeon park on 12/10/24.
//

import CoreData
import UIKit

final class ContactDataManager {
    static let shared = ContactDataManager()
    
    private init() {}

    private var context: NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("AppDelegate 접근 실패")
        }
        return appDelegate.persistentContainer.viewContext
    }
    
    // create
    func createContactData(name: String, phoneNumber: String, profileImage: String) {
        let entityName = "ContactEntity"
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            print("Entity not found")
            return
        }
        
        let newContact = NSManagedObject(entity: entity, insertInto: context)

        newContact.setValue(name, forKey: ContactEntity.Key.name)
        newContact.setValue(phoneNumber, forKey: ContactEntity.Key.phoneNumber)
        newContact.setValue(profileImage, forKey: ContactEntity.Key.profileImage)
        
        do {
            try self.context.save()
            print("데이터 저장 성공")
        } catch {
            print("데이터 저장 실패\(error.localizedDescription)")
        }
    }
    
    // read
    func readContactData() -> [ContactEntity] {
        let fetchRequest: NSFetchRequest<ContactEntity> = ContactEntity.fetchRequest()

        do {
            return try self.context.fetch(fetchRequest)
        }
        catch {
            print("데이터 읽기 실패")
            return []
        }
    }
    
    // update
    func updateContactData(currentName: String, updateName: String) {
        let fetchRequest = ContactEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", currentName)
        
        do {
            let result = try self.context.fetch(fetchRequest)
            
            for data in result as [NSManagedObject] {
                data.setValue(updateName, forKey: ContactEntity.Key.name)
            }
            
            try self.context.save()
            print("데이터 업데이트 성공")
        } catch {
            print("데이터 업데이트 실패")
        }
    }
    
    // delete
    func deleteContactData(name: String) {
        let fetchRequest = ContactEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let result = try self.context.fetch(fetchRequest)
            
            for data in result as [NSManagedObject] {
                self.context.delete(data)
            }
            print("데이터 삭제 성공")
            
        }  catch {
            print("데이터 삭제 실패")
        }
    }
}
