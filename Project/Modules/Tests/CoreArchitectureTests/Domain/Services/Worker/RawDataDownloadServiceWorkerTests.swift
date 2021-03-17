@testable import CoreArchitecture
import CoreInterfaces
import DDXNetwork
import XCTest

class RawDataDownloadServiceWorkerTests: XCTestCase {

    var sut: RawDataDownloaderWorker!
    var service: RequestServicePort!

    func testGetData__whenMakeRequest_itFails() {

        // GIVEN

        let error = NSError(domain: "Expected error", code: 555, userInfo: nil)
        let service = MockedRequestServiceAdapter(error: error)
        sut = RawDataDownloaderWorker(service: service)
        let expectation = XCTestExpectation()

        // WHEN

        sut.getData(
            from: "https://teste.com",
            onCompletion: { data in
                XCTFail("Unexpected error. It shout get a fail")
                expectation.fulfill()
            },

            onError: { error in
                // THEN

                let error = error as NSError
                XCTAssertEqual(error.code, 555)
                XCTAssertEqual(error.domain, "Expected error")
                expectation.fulfill()
            }
        )

        wait(for: [expectation], timeout: 10.0)
    }

    func testGetData__whenMakeRequest_itHasSuccess() {

        // GIVEN
        let expectedText = "ABCDEF"
        let data = expectedText.data(using: .utf8)!
        let service = MockedRequestServiceAdapter(data: data)

        sut = RawDataDownloaderWorker(service: service)
        let expectation = XCTestExpectation()

        // WHEN

        sut.getData(
            from: "https://teste.com",
            onCompletion: { data in
                guard let text = String(data: data, encoding: .utf8) else {
                    XCTFail("Could not convert data to text")
                    return
                }

                XCTAssertEqual(text, expectedText)
                expectation.fulfill()
            },

            onError: { error in
                
                // THEN

                XCTFail("Unexpected error. It shout be success")
                expectation.fulfill()
            }
        )

        wait(for: [expectation], timeout: 10.0)
    }

}
