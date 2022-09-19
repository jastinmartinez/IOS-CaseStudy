import XCTest
import Darwin

class TaxCalculatorTest : XCTestCase {
    
    private var sut: TaxCalculator!
    
    override func tearDown() {
        super.tearDown()
        self.sut = nil
    }
    
    override func setUp() {
        super.setUp()
        self.sut = TaxCalculator()
    }
    func test_createTaxCalculator() {
        XCTAssertNotNil(sut)
    }

    func test_WhenEnterSalary_ReturnNetSalary() {
        let netSalary = try? sut.calculate(with: 100)
        XCTAssertEqual(netSalary, 70, "net salary should be salary with 30 percent less")
    }

    func test_WhenNegativeSalary_ReturnNegativeSalaryError() {
        do {
            try sut.calculate(with: -100)
        } catch let error as TaxCalculator.Error {
            XCTAssertEqual(error, .negativeSalary)
        } catch {
            XCTFail("error should be type TaxCalculator")
        }
    }

    func test_WhenEnterZeroSalary_ReturnZeroSalaryError() {
        do {
            try sut.calculate(with: 0)
        } catch let error as TaxCalculator.Error {
            XCTAssertEqual(error, .zeroSalary)
        } catch {
            XCTFail("error should be type TaxCalculator")
        }
    }

    func test_WhenDynamicPercent_ReturnNetSalaryWithDynamicPercentApplied() {
        let netSalary = try? sut.calculate(with: 100, percent: 10)
        XCTAssertEqual(netSalary, 90)
    }
    
    func test_WhenNotDynamicPercent_ReturnNetSalaryWithDefaultPercentApplied() {
        let netSalary = try? sut.calculate(with: 100)
        XCTAssertEqual(netSalary, 70)
    }
    
    func test_WhenEnterNegativePercent_ReturnNegativePercentError() {
        do {
            try sut.calculate(with: 100, percent: -10)
        } catch let error as TaxCalculator.Error {
            XCTAssertEqual(error, .negativeOrZeroPercent)
        } catch {
            XCTFail("error should be type TaxCalculator")
        }
    }
    
    func test_WhenEnterZeroPercent_ReturnNetSalaryCalculatedWithDefaultPercent() {
        let netSalary = try? sut.calculate(with: 100)
        XCTAssertEqual(netSalary, 70)
    }
    
    func test_WhenEnterPercentGreaterThan100_ReturnPercentOutOfRange() {
        do {
            try sut.calculate(with: 100, percent: 101)
        } catch let error as TaxCalculator.Error {
            XCTAssertEqual(error, .percentOutOfRange)
        } catch {
            XCTFail("error should be type TaxCalculator")
        }
    }
}

class TaxCalculator {
    
    public enum Error : Swift.Error {
        case negativeSalary
        case zeroSalary
        case negativeOrZeroPercent
        case percentOutOfRange
    }
    
    func calculate(with salary: Double, percent: Int = 30) throws -> Double {
        try taxSalaryCalculationBussinessRule(salary: salary, percent: percent)
        let percent = calculatePercent(with: percent)
        return salary - (salary * percent)
    }
    
    fileprivate func taxSalaryCalculationBussinessRule(salary: Double, percent: Int) throws {
        try verifyIsNotNegativeSalary(salary)
        try verifyIsNotZeroSalary(salary)
        try verifyIsNotNegativePercent(percent)
        try veirfyPercentIsNotOutOfRange(percent)
    }
    
    fileprivate func calculatePercent(with percent: Int) -> Double  {
        return Double(percent) / Double(100)
    }
    
    fileprivate func verifyIsNotNegativeSalary(_ salary: Double) throws  {
        guard salary > -1 else {
            throw Error.negativeSalary
        }
    }
    
    fileprivate func verifyIsNotZeroSalary(_ salary: Double) throws  {
        guard salary > 0 else {
            throw Error.zeroSalary
        }
    }
    
    fileprivate func verifyIsNotNegativePercent(_ percent: Int) throws  {
        guard percent > 0 else {
            throw Error.negativeOrZeroPercent
        }
    }
    
    fileprivate func veirfyPercentIsNotOutOfRange(_ percent: Int) throws  {
        guard percent < 100 else {
            throw Error.percentOutOfRange
        }
    }
}

TaxCalculatorTest.defaultTestSuite.run()
