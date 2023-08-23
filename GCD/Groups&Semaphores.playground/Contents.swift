import UIKit

var greeting = "Hello, playground"



// group some task

let group = DispatchGroup()

let concurrentQueue = DispatchConcurrentQueue(label: "com.concurrent")

var timer: Double {
    return Double.random(in: 1...5)
}
var counter = 0
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

// there's some



