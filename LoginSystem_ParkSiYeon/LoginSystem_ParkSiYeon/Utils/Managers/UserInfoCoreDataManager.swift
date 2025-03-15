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
        let container = NSPersistentContainer(name: "UserInfoCoreData")
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
        let userInfo = UserInfoCoreData(context: context)
        userInfo.email = email
        userInfo.password = password
        userInfo.nickname = nickname
        
        // 저장
        saveContext()
        
        // UserDefaults에 닉네임 저장
        UserDefaultsManager.shared.saveNickname(nickname)
    }
}

// MARK: - Fetch UserInfoCoreData

extension UserInfoCoreDataManager {
    func fetchUserByEmail(email: String) -> UserInfoCoreData? {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<UserInfoCoreData> = UserInfoCoreData.fetchRequest()
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

// MARK: - Check UserInfoCoreData

extension UserInfoCoreDataManager {
    func isEmailAlreadyExists(email: String) -> Bool {
        let context = getContext()
        let fetchRequest: NSFetchRequest<UserInfoCoreData> = UserInfoCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            let results = try context.fetch(fetchRequest)
            return !results.isEmpty
        } catch {
            print("Failed to fetch email: \(error)")
            return false
        }
    }
}

// MARK: - Delete UserInfoCoreData

extension UserInfoCoreDataManager {
    func deleteUser(user: UserInfoCoreData) {
        let context = getContext()
        context.delete(user)
        saveContext()
    }
}
