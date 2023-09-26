//
//  BowTie.swift
//  Chap2BowTies
//
//  Created by Jastin on 19/9/23.
//

import Foundation
import CoreData
import UIKit

public enum BowTieConstant: String {
    case entity = "BowTie"
}

@objc public class BowTie: NSManagedObject {
    
    @NSManaged public var name: String?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var lastWorn: Date?
    @NSManaged public var rating: Double
    @NSManaged public var searchKey: String?
    @NSManaged public var timesWorn: Int32
    @NSManaged public var id: UUID?
    @NSManaged public var url: URL?
    @NSManaged public var photoData: Data?
    @NSManaged public var tintColor: UIColor?
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<BowTie> {
        return NSFetchRequest<BowTie>(entityName: BowTieConstant.entity.rawValue)
    }
}
