//
//  StorageController.swift
//  Chap2BowTies
//
//  Created by Jastin on 22/9/23.
//

import Foundation
import CoreData

final class StorageController {

    private let storeCoordinator: NSPersistentContainer
    init() {
        self.storeCoordinator = NSPersistentContainer(name: "Bowtie")
    }
    convenience init?(register: () -> Void) {
        self.init()
        register()
    }
    
    convenience init?(registers: [() -> Void]) {
        self.init()
        registers.forEach({ $0() })
    }
    
    private func sampleData() {
        let fetchRequest = BowTie.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "searchKey != nil")
    }
}
