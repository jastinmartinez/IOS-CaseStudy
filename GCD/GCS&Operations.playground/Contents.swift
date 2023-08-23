import UIKit

//Queue / Task (FIFO)
// Serial
// Concurrent
// Async
// Sync


let serialQueue = DispatchSerialQueue(label: "demo.serial.com")
// a, b, c (Serial == SINGLE THREAD)
// EXEC -> a, b, c
let concurrentQueue = DispatchQueue(label: "concurrent.queue.com", attributes: .concurrent)
// a, b, c = (Concurrent -> MULTIPLES THREAD)
// EXEC -> a -> b -> c

var timer: Double {
    return Double.random(in: 1...5)
}

func syncTask1() {
    let timer = timer
    print("syncTask1 inverval of: \(timer)")
    Thread.sleep(forTimeInterval: timer)
    print("syncTask1")
}

func syncTask2() {
    let timer = timer
    print("syncTask2 inverval of: \(timer)")
    Thread.sleep(forTimeInterval: timer)
    print("syncTask2")

}

func syncTask3() {
    let timer = timer
    print("syncTask3 inverval of: \(timer) ")
    Thread.sleep(forTimeInterval: timer)
    print("syncTask3")
}


print(" ")
print("Serial Sync")
serialQueue.sync {
    syncTask1()
}


serialQueue.sync {
    syncTask2()
}


serialQueue.sync {
    syncTask3()
}

print(" ")
print("Serial Async")
serialQueue.async {
    syncTask1()
}


serialQueue.async {
    syncTask2()
}


serialQueue.async {
    syncTask3()
}


print("Concurrent Sync")
concurrentQueue.sync {
    syncTask1()
}

concurrentQueue.sync {
    syncTask2()
}

concurrentQueue.sync {
    syncTask3()
}

print(" ")
print("Concurrent Async")
concurrentQueue.async {
    syncTask1()
}


concurrentQueue.async {
    syncTask2()
}


concurrentQueue.async {
    syncTask3()
}

print(1)

let workItem = DispatchWorkItem {
    let timer = timer
    print("workItem inverval start: \(timer) ")
    Thread.sleep(forTimeInterval: timer)
    print("workItem inverval when end: \(timer) ")
}
serialQueue.async(execute: workItem)
concurrentQueue.async(execute: workItem)
concurrentQueue.sync(execute: workItem)
serialQueue.sync(execute: workItem)
