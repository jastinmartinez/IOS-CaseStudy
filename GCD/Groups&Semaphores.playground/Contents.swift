import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true


// group some task

let group = DispatchGroup()

let concurrentQueue = DispatchConcurrentQueue(label: "com.concurrent")

var timer: Double {
    return Double.random(in: 1...5)
}

let workItem = DispatchWorkItem {
    let timer = timer
    print("start: \(timer)")
    Thread.sleep(forTimeInterval: timer)
    print("finish: \(timer)")
}


concurrentQueue.async(group: group,execute: workItem)
concurrentQueue.async(group: group,execute: workItem)
concurrentQueue.async(group: group,execute: workItem)
concurrentQueue.async(group: group,execute: workItem)
concurrentQueue.async(group: group,execute: workItem)
// group has timeout
if group.wait(timeout: .now() + 1) == .timedOut {
    print("fail man you gotta execute this task faster")
}

//group has wait sync operations
group.wait()

group.notify(queue: .global()) {
    print("all task attach to the group finish 1, this work event if it's on diferent queues")
}

let serialQueue = DispatchSerialQueue(label: "serial.com.queue")
print("serialQueue")
serialQueue.async(group: group,execute: workItem)
serialQueue.async(group: group,execute: workItem)
serialQueue.async(group: group,execute: workItem)
serialQueue.async(group: group,execute: workItem)
serialQueue.async(group: group,execute: workItem)

group.notify(queue: .global()) {
    print("all task attach to the group finish 2, this work event if it's on diferent queues")
}

// if you wanna make sure you're waiting for any aync call inside a func you can still use group to manage that


let someSerialQueue = DispatchSerialQueue(label: "some.serial.queue")

var randomTimer: Double {
    return Double.random(in: 1...10)
}

func addTwoNumbers(lhs: Int, lhr: Int, completion: @escaping (Int) -> Void) {
    Thread.sleep(forTimeInterval: Date().distance(to: Date.now + 1))
    completion(lhs + lhr)
}

func addTwoNumbersInGroup(group: DispatchGroup,lhs: Int, lhr: Int, completion: @escaping (Int) -> Void) {
    var sumGroupTotal = 0
    someSerialQueue.async(group: group) {
        addTwoNumbers(lhs: lhs, lhr: lhr) { sum in
            Thread.sleep(forTimeInterval: Date().distance(to: Date.now + 1))
            sumGroupTotal = sum
        }
    }
    group.notify(queue: .global()) {
        completion(sumGroupTotal)
    }
}

// test `addTwoNumbers` && `addTwoNumbersInGroup` completion when using loop

var numberGenerator: Int {
    return Int.random(in: 1...100)
}

var counter = 5
let someGroup = DispatchGroup()
while counter > 0 {
    print(" im just less sync \(counter)")

    addTwoNumbersInGroup(group: someGroup, lhs: numberGenerator, lhr: numberGenerator) { sum in
        print("addTwoNumbersInGroup: \(sum)")
    }
    
    addTwoNumbers(lhs: numberGenerator, lhr: numberGenerator) { sum in
        print("addTwoNumbers: \(sum)")
    }
  
    counter -= 1
}
