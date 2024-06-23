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
        let (sut, inventory) = makeSUT()
        sut.sellApples(amount: 1)
        
        let value = try #require(inventory.inventory[.appple])
        
        #expect(value == 1)
    }
    
    @Test func canSellMoreThanOneApple() throws {
        let (sut, inventory) = makeSUT()
        sut.sellApples(amount: 2)
        
        let value = try #require(inventory.inventory[.appple])
        
        #expect(value == 2)
    }
    
}

// MARK: HELPERS

private func makeSUT() -> (SuperMarket, InventoryMock) {
    let inventory = InventoryMock()
    let sut = SuperMarket(Inventory: inventory)
    return (sut, inventory)
}

final class InventoryMock: Inventory {
    private(set) var inventory = [Food: Int]()
    
    func register(food: Food, amount: Int) {
        inventory[food] = amount
    }
}


