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
    case pear
}

final class SuperMarket {
    private let inventory: Inventory
    
    init(Inventory: Inventory) {
        self.inventory = Inventory
    }
    
    func sellApples(amount: Int = 0) {
        inventory.register(food: .appple, amount: amount)
    }
    
    func sellOtherKindOfFood(food: Food, amount: Int) {
        inventory.register(food: food, amount: amount)
    }
}


struct SuperMarketTests {
    
    @Test("test that SuperMarket can sell Apples") func canSellApples() throws {
        let (sut, inventory) = makeSUT()
        sut.sellApples(amount: 1)
        
        let value = try #require(inventory.inventory[.appple])
        
        #expect(value == 1)
    }
    
    
    @Test(arguments: [Food.appple, .pear]) func canSellOtherKindOfFoodWithSameValue(food: Food) throws {
        let (sut, inventory) = makeSUT()
        sut.sellOtherKindOfFood(food:  food, amount: 1)
        
        let value = try #require(inventory.inventory[food])
        
        #expect(value == 1)
    }
    
    @Test(arguments: [FoodMapValue(food: .appple, value: 0),
                      FoodMapValue(food: .pear, value: 3)]) func canSellOtherKindOfFoodWithDifferentValues(map: FoodMapValue) throws {
        let (sut, inventory) = makeSUT()
        sut.sellOtherKindOfFood(food:  map.food, amount: map.value)
        
        let value = try #require(inventory.inventory[map.food])
        
        #expect(value == map.value)
    }
    
}

struct FoodMapValue {
    let food: Food
    let value: Int
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


