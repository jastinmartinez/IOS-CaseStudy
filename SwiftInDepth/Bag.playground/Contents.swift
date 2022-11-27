import UIKit

struct Bag<Element: Hashable> {
    private var elementTracker = [Element: Int]()
    
    mutating func insert(_ element: Element) {
        if let existingElement = self.elementTracker[element] {
            self.elementTracker[element] = existingElement + 1
        } else {
            self.elementTracker[element] = 1
        }
    }
    
    mutating func remove(_ element: Element) {
        self.elementTracker[element] = nil
    }
    
    var count: Int {
        return self.elementTracker.values.reduce(0, +)
    }
}

extension Bag: CustomStringConvertible {
    var description: String {
        var summary = String()
        for (key, value) in elementTracker {
            let times = value == 1 ? "time" : "times"
            summary.append("\(key) occurs \(value) \(times)\n")
        }
        return summary
    }
}

struct BagIterator<Element: Hashable>: IteratorProtocol {
    private var elementTracker: [Element: Int]
    
    init(elementTracker: [Element: Int]) {
        self.elementTracker = elementTracker
    }
    
    mutating func next() -> Element? {
        guard let (key, value) = self.elementTracker.first else {
            return nil
        }
        self.elementTracker[key] = value > 1 ? (value - 1) : nil
        return key
    }
}

extension Bag: Sequence {
    func makeIterator() -> BagIterator<Element> {
        return BagIterator<Element>(elementTracker: self.elementTracker)
    }
}

extension Bag: ExpressibleByArrayLiteral {
    typealias ArrayLiteralElement = Element
    
    init(arrayLiteral elements: Element...) {
        self.elementTracker = elements.reduce(into: [Element: Int](), { partialResult, element in
            if let count = partialResult[element] {
                partialResult[element] = count + 1
            } else {
                partialResult[element] = 1
            }
        })
    }
}

let colors: Bag = ["a"]


// Infinite sequence

struct InfiniteSequence<Element: Hashable>: Sequence, ExpressibleByArrayLiteral {
    typealias ArrayLiteralElement = Element
    private var elementTracker = [Element]()
    func makeIterator() -> some IteratorProtocol {
        var index = 0
        return AnyIterator<Element>({
            let element = self.elementTracker[index]
            index = index == self.elementTracker.count - 1 ? 0 : index + 1
            return element
        })
    }
    
    init(arrayLiteral elements: ArrayLiteralElement...) {
        self.elementTracker = elements.reduce(into: [Element](), { partialResult, element in
            partialResult.append(element)
        })
    }
}


let infinite: InfiniteSequence = ["a","b","c","d"]

for (index, letter) in zip(0..<100, infinite) {
    print("\(index): \(letter)")
}



var a = [1,3,2,4]

let r = a.partition { val in
    return val > 0
}

a.swapAt(0, 1)
