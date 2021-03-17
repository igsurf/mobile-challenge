@testable import CoreArchitecture
import CoreInterfaces
import XCTest
import DDXNetwork

class RequestServiceAdapterTests: XCTestCase {

    var sut: RequestServiceAdapter!

    func testRequestData__whenMakeRequest__itSuccess() {
        let data = loginResponse().data(using: .utf8)!
        let request = MockRequest.create()
        let httpMock = HTTPServiceMock(data: data)
        let expectation = XCTestExpectation()

        sut = RequestServiceAdapter(decoder: nil, http: httpMock)


        sut.requestData( from: request, interceptor: nil, additionalHeaders: [:]) { result in
            switch result {
            case .success(let resultData):
                XCTAssertEqual(resultData, data)
                expectation.fulfill()

            default:
                XCTFail("Not foreseen situation")
            }
        }

        wait(for: [expectation], timeout: 10.0)
    }

    func testRequestData__whenMakeRquest__itFails() {
        let request = MockRequest.create()
        let error = NSError(domain: "unknown error", code: 12345, userInfo: nil)
        let httpMock = HTTPServiceMock(error: error)

        sut = RequestServiceAdapter(decoder: nil, http: httpMock)

        let expectation = XCTestExpectation()

        sut.requestData(from: request, interceptor: nil, additionalHeaders: [:]) { result in
            switch result {
            case .failure(let resultError):
                let err = resultError as NSError
                XCTAssertEqual(err.code, 12345)
                XCTAssertEqual(err.domain, "unknown error")
                XCTAssertTrue(err.userInfo.isEmpty)
                expectation.fulfill()

            default:
                XCTFail("Not foreseen situation")
            }
        }

        wait(for: [expectation], timeout: 10.0)
    }

    func loginResponse() -> String {
        let result = ""
            + "{ "
            + "     \"accessToken\": \"1234567890\", "
            + "     \"refreshToken\": \"ABCDEFGHTJ\" "
            + "}"

        return result
    }

}

//====================
//      HELPERS
//====================

fileprivate final class HTTPServiceMock: HttpService {

    var request: RequestModel!
    var headers: HttpHeaders!

    let data: Data!
    let error: Error!

    init(data: Data) {
        self.data = data
        self.error = nil
    }

    init(error: Error) {
        self.error = error
        self.data = nil
    }

    func request(_ req: RequestModel, additionalHeaders: HttpHeaders, completion: HttpCompletion?) {
        self.request = req
        self.headers = additionalHeaders

        if self.data != nil {
            completion?(.success(self.data))
            return
        }

        if self.error != nil {
            completion?(.failure(error))
            return
        }

        XCTFail("No test cases reached")
    }
}

fileprivate struct MockRequest: ServiceRequestEntity {
    var url: String
    var method: HttpMethod
    var body: HttpBody?
    var headers: HttpHeaders
    var timeout: TimeInterval

    static func create() -> ServiceRequestEntity {
        let body = "1234567890".data(using: .utf8)
        let headers = ["foo": "bar"]

        let request = MockRequest(url: "http://test.tst",
                                  method: HttpMethod.post,
                                  body: body,
                                  headers: headers,
                                  timeout: 30.0)

        return request
    }
}

