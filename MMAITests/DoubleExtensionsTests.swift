import XCTest
@testable import MMAI

class DoubleExtensionsTests: XCTestCase {

    func testAsCurrencyWith2Decimals() {
        XCTAssertEqual(1234.56.asCurrencyWith2Decimals(), "$ 1,234.56")
        XCTAssertEqual(12.34.asCurrencyWith2Decimals(), "$ 12.34")
        XCTAssertEqual(0.12.asCurrencyWith2Decimals(), "$ 0.12")
    }
    
    func testAsCurrencyWith6Decimals() {
        XCTAssertEqual(1234.56.asCurrencyWith6Decimals(), "$ 1,234.56")
        XCTAssertEqual(12.3456.asCurrencyWith6Decimals(), "$ 12.3456")
        XCTAssertEqual(0.123456.asCurrencyWith6Decimals(), "$ 0.123456")
    }
    
    func testAsNumberString() {
        XCTAssertEqual(1.2345.asNumberString(), "1.23")
        XCTAssertEqual(12.34.asNumberString(), "12.34")
    }
    
    func testAsPercentString() {
        XCTAssertEqual(1.2345.asPercentString(), "1.23%")
        XCTAssertEqual(12.34.asPercentString(), "12.34%")
    }
    
    func testFormattedWithAbbreviations() {
        XCTAssertEqual((-12343678901234).formattedWithAbbreviations(), "-12.34Tr")
        XCTAssertEqual(123436789012.formattedWithAbbreviations(), "123.44Bn")
        XCTAssertEqual(1234567890.formattedWithAbbreviations(), "1.23Bn")
        XCTAssertEqual(12343678.formattedWithAbbreviations(), "12.34M")
        XCTAssertEqual(123436.formattedWithAbbreviations(), "123.44K")
        XCTAssertEqual(1234.formattedWithAbbreviations(), "1.23K")
        XCTAssertEqual(12.formattedWithAbbreviations(), "12.00")
    }
    
    func testAsCm() {
        XCTAssertEqual(12.34.asCm(), "12.34cm")
    }
    
    func testAsLbs() {
        XCTAssertEqual(12.34.asLbs(), "12.34lbs")
    }
    
    func testAsKg() {
        XCTAssertEqual(12.34.asKg(), "12.34kg")
    }
    
    func testAsInches() {
        XCTAssertEqual(12.34.asInches(), "12.34\"")
    }
}

class IntExtensionsTests: XCTestCase {
    
    func testAsCm() {
        XCTAssertEqual(12.asCm(), "12cm")
    }
    
    func testAsLbs() {
        XCTAssertEqual(12.asLbs(), "12lbs")
    }
    
    func testAsKg() {
        XCTAssertEqual(12.asKg(), "12kg")
    }
    
    func testAsInches() {
        XCTAssertEqual(12.asInches(), "12\"")
    }
    
    func testAsPercent() {
        XCTAssertEqual(12.asPercent(), "12%")
    }
}
