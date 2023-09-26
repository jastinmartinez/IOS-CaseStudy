//
//  ColorAttributeTransformer.swift
//  Chap2BowTies
//
//  Created by Jastin on 19/9/23.
//

import UIKit

class ColorAttributeTransformer: NSSecureUnarchiveFromDataTransformer {
    override class var allowedTopLevelClasses: [AnyClass] {
        return [UIColor.self]
    }
    
    static func register() {
        let className = String(describing: ColorAttributeTransformer.self)
        let name = NSValueTransformerName(className)
        let transformer = ColorAttributeTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
}
