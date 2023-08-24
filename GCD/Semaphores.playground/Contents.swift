import Foundation
import PlaygroundSupport

/*
 the `semaphore` is an object that control access to resources when you have multiple execcution
 */

PlaygroundPage.current.needsIndefiniteExecution = true

let sempaphore = DispatchSemaphore(value: 2)
let queue = DispatchConcurrentQueue(label: "com.concurrent")
let group = DispatchGroup()

for value in 1...10 {
    queue.async(group: group) {
        sempaphore.wait()
        defer { sempaphore.signal() }
        print("start image \(value)")
        Thread.sleep(forTimeInterval: 3)
        print("finish image \(value)")
    }
}

group.notify(queue: .global()) {
    PlaygroundPage.current.finishExecution()
}


