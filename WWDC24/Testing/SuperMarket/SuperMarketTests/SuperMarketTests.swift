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

enum Food: CaseIterable {
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
    
    
    @Test("Inventory prepare  available amount offood") func inventoryAmountOfFoodByDefaultIsTen() throws {
        let (_, inventory) = makeSUT()
        
        let availableAmountOfApples = try #require(inventory.inventory[.appple])
        
        #expect(availableAmountOfApples == 10)
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
    
    init() {
        for food in Food.allCases {
            self.inventory[food] = 10
        }
    }
    
    func register(food: Food, amount: Int) {
        inventory[food] = amount
    }
}


