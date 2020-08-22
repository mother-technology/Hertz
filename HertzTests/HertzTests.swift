@testable import Hertz
import XCTest

class HertzTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let t: [Int] = [1,2,3,4,5]
        
        XCTAssertEqual(1, t[circular: 0])
        XCTAssertEqual(5, t[circular: 4])
        
        XCTAssertEqual(1, t[circular: 5])
        XCTAssertEqual(1, t[circular: 10])

        XCTAssertEqual(5, t[circular: -1])
        XCTAssertEqual(5, t[circular: -6])

        XCTAssertEqual(4, t[circular: -2])
        XCTAssertEqual(4, t[circular: -7])

        XCTAssertEqual(3, t[circular: -3])
        XCTAssertEqual(3, t[circular: -8])

        XCTAssertEqual(2, t[circular: -4])
        XCTAssertEqual(2, t[circular: -9])

        XCTAssertEqual(1, t[circular: -5])
        XCTAssertEqual(1, t[circular: -10])
    }
}
