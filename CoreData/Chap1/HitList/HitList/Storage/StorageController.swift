//
//  StorageController.swift
//  HitList
//
//  Created by Jastin on 16/9/23.
//

import Foundation
import CoreData

protocol StorageControllerProtocol: AnyObject {
    func save(name: String)
    func get() -> [String]
}

final class StorageController: StorageControllerProtocol {
  
    private var people = [NSManagedObject]()
    private let persistentContainer: NSPersistentContainer
    
    init() {
        self.persistentContainer = NSPersistentContainer(name: Constant.contaniner.rawValue)
        self.persistentContainer.loadPersistentStores { storeDescription, error in
            if let error = error as? NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    private func buildPerson(name: String,
                             entity: NSEntityDescription,
                             manageObjectContext: NSManagedObjectContext) -> NSManagedObject {
        let person = NSManagedObject(entity: entity, insertInto: manageObjectContext)
        person.setValue(name, forKeyPath: Constant.name.rawValue)
        return person
    }
    
    func save(name: String) {
        do {
            let manageObjectContext = self.persistentContainer.viewContext
            guard let entity = NSEntityDescription.entity(forEntityName: Constant.entity.rawValue, in: manageObjectContext) else {
                return
            }
            let person = buildPerson(name: name,
                                     entity: entity,
                                     manageObjectContext: manageObjectContext)
            try self.persistentContainer.viewContext.save()
            self.people.append(person)
        } catch let error as NSError {
            fatalError("could not save. \(error), \(error.userInfo)")
        }
    }
    
    func get() -> [String] {
        return self.people.lazy.compactMap({ $0.value(forKey: Constant.name.rawValue) as? String})
    }
}

extension StorageController {
    private enum Constant: String {
        case contaniner = "HitList"
        case entity = "Person"
        case name
    }
}
