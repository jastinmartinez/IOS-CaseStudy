import UIKit


/*
 Polimorfismo
 - override ->
 props -> h -> p
 func -> h -> p
 p -> func
 
 - overload
    dataType: -> Int, String, any so forth
    func wrap(param: String) -> Sting
    func wrap(param: Int) -> Int
 
 monomorphization
 
 witness table
 */


func firstLast(array: [Int]) -> (first: Int, last: Int) {
    return (array[array.count - array.count], array[array.count - 1])
}

func firstLast<T>(array: [T]) -> (first: T, last: T) {
    return (array[array.count - array.count], array[array.count - 1])
}

let (first, last) = firstLast(array: [1,2,3,4,5])
let (first1, last1) = firstLast(array: ["1","2","3","1","2"])


func example<T>(_ arg: T) -> Int? {
    return arg as? Int
}

func wrap<T>(value: Int, secondaValue: T) -> ([Int], Int)? {
    if let second = secondaValue as? Int {
        return ([value], second)
    }
    return nil
}


func lowest<T: Comparable>(_ list: [T]) -> T? {
    return list.sorted(by: <).first
}


func wrap(param: String) -> String {
    return param
}


func wrap(param: Int) -> Int {
    return param
}

wrap(param: 0)


lowest([12,2,3])
lowest(["asas","ssdsdsdsddsd","asdasd"])


/*
 Write a function that, given an array, returns a dictionary of the occurrences of each element inside the array.
 */

func occurrences<T>(_ array: [T]) -> [T: Int] {
    var occurrencesDic = [T: Int]()
    for item in array {
        if let counter = occurrencesDic[item] {
            occurrencesDic[item] = counter + 1
        } else {
            occurrencesDic[item] = 1
        }
    }
    return occurrencesDic
}


occurrences([1,2,2,4])


func printGenericDescription<T: CustomStringConvertible & CustomDebugStringConvertible>(param: T) {
    print(param.debugDescription)
    print(param.description)
    print(param)
}



struct Pair<T: Hashable, U: Hashable> : Hashable {
    var right: T
    var left: U
}

let pair = Pair(right: 1, left: "a")

//print(pair.hashValue)



class Demo {
}

class SubDemo: Demo {
    
}

func optionalDemo(_ value: Demo?) {
    print(value.debugDescription)
}

optionalDemo(SubDemo())




