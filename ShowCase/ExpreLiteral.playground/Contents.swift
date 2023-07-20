import UIKit

var greeting = "Hello, playground"


let array = [1,2,3]


struct Example {
    var demoValues: [Int]
}


extension Example: ExpressibleByArrayLiteral {
    typealias ArrayLiteralElement = Int
    
    init(arrayLiteral elements: Int...) {
        self.demoValues = elements
    }
}

let example = Example(arrayLiteral: 1,3,4)

print(example.demoValues)
