//
//  UserInfoCoreDataManager.swift
//  LoginSystem_ParkSiYeon
//
//  Created by siyeon park on 3/15/25.
//

import CoreData
import UIKit

final class UserInfoCoreDataManager {
    static let shared = UserInfoCoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SignUpInfoCoreData")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Unresolved error \(error), \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func getContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}

// MARK: - Save UserInfoCoreData

extension UserInfoCoreDataManager {
    func saveUserInfo(email: String, password: String, nickname: String) {
        let context = getContext()
        
        // 새로운 UserInfo 객체 생성
        let userInfo = UserInfo(context: context)
        userInfo.email = email
        userInfo.password = password
        userInfo.nickname = nickname
        
        // 저장
        saveContext()
    }
}

// MARK: - Fetch UserInfoCoreData

extension UserInfoCoreDataManager {
    func fetchUserByEmail(email: String) -> UserInfo? {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<UserInfo> = UserInfo.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            let users = try context.fetch(fetchRequest)
            return users.first
        } catch {
            print("Error fetching user: \(error)")
            return nil
        }
    }
}

