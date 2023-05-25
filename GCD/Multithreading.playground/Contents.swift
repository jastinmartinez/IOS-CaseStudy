import UIKit
import XCTest
import Foundation

/* MULTITHREADING */

/* CONCURRENCY */
///basically means that two or more task can run in parallel.

/* GCD */
/// Since IOS 4 apple introduce 'GCD' an API that abstract the handling of concurrency and threads using queues.
/// Basically 'GCD' it's an scheduler or dispatcher of queues.
/// GCD -> Grand Central Dispatch

/* QUEUE */
/// A 'queue' it's an abstract data type that servers a collection of elements using FIFO operation.
/// FIFO -> First in First Out
 
/* QUEUE */ /* TYPES */
///  'serial' basically guarantee that all task submited run on single thread also in order meaning that it wait until first task finished to execute second one.
///  'Concurrent' basically can run more that on thread and the submitted task can run simultaneously.

class ConcurrencyTest: XCTestCase {
    
    func testConcurrencyQueueAsync() {
        let lock = NSRecursiveLock()
        let limit = 5000
        var array = [Int]()
        let dispatch = DispatchQueue(label: "testConcurrencyQueueAsync",attributes: .concurrent)
        var expectations = [XCTestExpectation]()
        for index in 1...limit {
            lock.lock()
            let exp = expectation(description: "perform insert of \(index) to array async")
            dispatch.async {
                array.append(index)
                lock.unlock()
                exp.fulfill()
            }
            expectations.append(exp)
        }
        wait(for: expectations, timeout: 10)
        XCTAssertEqual(array.count, limit)
    }
    
}

ConcurrencyTest.defaultTestSuite.run()


