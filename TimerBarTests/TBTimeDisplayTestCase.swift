import XCTest
@testable import TimerBar

class TBTimeDisplayTestCase: XCTestCase {

    func testFormatsCommonCases() {
        XCTAssertEqual(TBTimeDisplay.display(    0.0), "00:00:00")
        XCTAssertEqual(TBTimeDisplay.display(    9.0), "00:00:09")
        XCTAssertEqual(TBTimeDisplay.display(   52.0), "00:00:52")
        XCTAssertEqual(TBTimeDisplay.display(   60.0), "00:01:00")
        XCTAssertEqual(TBTimeDisplay.display(   65.0), "00:01:05")
        XCTAssertEqual(TBTimeDisplay.display(  144.0), "00:02:24")
        XCTAssertEqual(TBTimeDisplay.display(  144.0), "00:02:24")
        XCTAssertEqual(TBTimeDisplay.display( 3600.0), "01:00:00")
        XCTAssertEqual(TBTimeDisplay.display( 3607.0), "01:00:07")
        XCTAssertEqual(TBTimeDisplay.display( 3761.0), "01:02:41")
        XCTAssertEqual(TBTimeDisplay.display( 7201.0), "02:00:01")
        XCTAssertEqual(TBTimeDisplay.display(36000.0), "10:00:00")
    }

    func testFormatsLargeTimes() {
        XCTAssertEqual(TBTimeDisplay.display(360000.0), "100:00:00")
    }

    func testFormatsFractionalIntervals() {
        // Should always round down
        XCTAssertEqual(TBTimeDisplay.display(65.12), "00:01:05")
        XCTAssertEqual(TBTimeDisplay.display(65.92), "00:01:05")
    }

}
