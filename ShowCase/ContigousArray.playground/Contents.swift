import Foundation
import XCTest


class Student {
    var grade: Int = 0
    var name: String = ""
}

class StudentTests: XCTestCase {
    let limit = 1000
    func test_ContigousArrayPerformance() {
        var array = ContiguousArray<Student>()
        let student = Student()
        var index = 0
        self.measure {
            while index < limit {
                array.append(student)
                index += 1
            }
        }
    }
    
    func test_ArrayPerformance() {
        var array = [Student]()
        let student = Student()
        var index = 0
        self.measure {
            while index < limit {
                array.append(student)
                index += 1
            }
        }
    }
}


StudentTests.defaultTestSuite.run()


