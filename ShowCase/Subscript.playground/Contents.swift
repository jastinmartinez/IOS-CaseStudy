import UIKit


/*
 Subscript are shortcuts for accesing elements in a collection
 */


let val = "know me better"


struct Example {
    let value: Int
    
    subscript(index: Int) -> Int {
        return value * index
    }
}


let example = Example(value: 3)
print(example[3])
