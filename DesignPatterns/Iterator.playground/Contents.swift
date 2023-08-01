import Foundation

protocol Iterator {
    associatedtype T
    func next() -> T
    func hasNext() -> Bool
}

protocol Aggregate {
    associatedtype T: Iterator
    func createIterator() -> T
}

// Exposable Representation
struct MenuItem {
    let name: String
    let detail: String
    let price: Double
}

extension MenuItem: CustomStringConvertible {
    var description: String {
        return "name: \(self.name) -> detail: \(self.detail) -> price: \(self.price)"
    }
}

// This will use dynamic
final class breakFast: Aggregate {
    
    typealias T = BreakFastIterator
    
    private var menuItemList = [MenuItem]()
    
    init() {
//        initial mock data
        self.menuItemList = Array(repeating: ":)", count: 30).map( { _ in return MenuItem(name: "Eggs \(Int.random(in: 1...30))",
                                                                                          detail: "Eggs \(Int.random(in: 1...30))",
                                                                                          price: Double.random(in: 1...100)) } )
    }
    
    func add(_ menuItem: MenuItem) {
        self.menuItemList.append(menuItem)
    }
    
    func createIterator() -> BreakFastIterator {
        return BreakFastIterator(menuItemList: self.menuItemList)
    }
}


final class BreakFastIterator: Iterator {
    
    typealias T = MenuItem
    
    private let menuItemList: [MenuItem]
    private var index = 0
    
    init(menuItemList: [MenuItem]) {
        self.menuItemList = menuItemList
    }
    
    func next() -> MenuItem {
        let menuItem = self.menuItemList[self.index]
        self.index += 1
        return menuItem
    }
    
    func hasNext() -> Bool {
        self.menuItemList.count > 0 && self.index < self.menuItemList.count
    }
}

final class Lunch: Aggregate {
    func createIterator() -> LunchIterator {
        <#code#>
    }
    
    typealias T = LunchIterator
}

final class LunchIterator: Iterator {
    func hasNext() -> Bool {
        <#code#>
    }
    
    
}


// the abstract class serving the available menu
final class WaitTress {
    private let breakFast: breakFast
    
    init(breakFast: breakFast) {
        self.breakFast = breakFast
    }
    
    func printMenu() {
        self.printMenu(self.breakFast.createIterator())
    }
    
    private func printMenu<I: Iterator>(_ iterator: I) where I.T == MenuItem {
        while iterator.hasNext() {
            print(iterator.next().description)
        }
    }
}

let waitTress = WaitTress(breakFast: breakFast())
waitTress.printMenu()

