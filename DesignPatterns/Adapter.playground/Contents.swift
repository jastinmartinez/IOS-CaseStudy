import Foundation


/*
 Adapter pattern refers to the abiliy transform the interface of a class to another.
 */

// This is out system Interface
protocol DomesticBirdsAction {
    func fly()
    func walk()
}

// This is our system Implementation
final class Duck: DomesticBirdsAction {
    func fly() {
        print("fly")
    }
    
    func walk() {
        print("walk")
    }
}



// This is the client Inteface
protocol WildBirdsAction {
    func fly()
    func walk()
}

final class Turkey: WildBirdsAction {
    func fly() {
        print("fly less")
    }
    
    func walk() {
        print("walk less")
    }
}

// This is the client Implementation
final class Client {
    private let wild: WildBirdsAction
    
    init(wild: WildBirdsAction) {
        self.wild = wild
    }
    
    func invoke() {
        self.wild.fly()
        self.wild.walk()
    }
}


/* if the clients required comunication to our system we can create the adapter to it*/


final class DomesticBirdsAdapter: WildBirdsAction {
    
    private let domestic: DomesticBirdsAction
    
    init(domestic: DomesticBirdsAction) {
        self.domestic = domestic
    }
    func fly() {
        self.domestic.fly()
    }

    func walk() {
        self.domestic.walk()
    }
}



let clientDomesticAdapter = Client(wild: DomesticBirdsAdapter(domestic: Duck()))
let clientWild = Client(wild: Turkey())
clientDomesticAdapter.invoke()
clientWild.invoke()

