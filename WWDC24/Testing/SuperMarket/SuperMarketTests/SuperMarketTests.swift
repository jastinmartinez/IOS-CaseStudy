//
//  SuperMarketTests.swift
//  SuperMarketTests
//
//  Created by Jastin Martinez on 6/23/24.
//

import Testing

protocol Inventory {
    func register(food: Food, amount: Int)
}

enum Food {
    case appple
}

final class SuperMarket {
    private let inventory: Inventory
    
    init(Inventory: Inventory) {
        self.inventory = Inventory
    }
    
    func sellApples(amount: Int = 0) {
        inventory.register(food: .appple, amount: amount)
    }
}



struct SuperMarketTests {
    
    @Test("test that SuperMarket can sell Apples") func canSellApples() throws {
        let inventory = InventoryMock()
        let sut = SuperMarket(Inventory: inventory)
        sut.sellApples(amount: 1)
        
        let value = try #require(inventory.inventory[.appple])
        
        #expect(value == 1)
    }
}

final class InventoryMock: Inventory {
    private(set) var inventory = [Food: Int]()
    
    func register(food: Food, amount: Int) {
        inventory[food] = amount
    }
}


