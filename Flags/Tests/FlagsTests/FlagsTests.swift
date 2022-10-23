import XCTest
@testable import Flags

final class FlagsTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Flags().text, "Hello, World!")
    }
}
