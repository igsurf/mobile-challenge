@testable import CoreArchitecture
import CoreInterfaces
import DDXNetwork
import XCTest

class PullRequestsServiceWorkerTests: XCTestCase {

    var sut: PullRequestsServiceWorker!
    var service: RequestServicePort!

    func testGetPullRequests__whenMakeRequest__itFails() {

        // GIVEN

        let error = NSError(domain: "Expected error", code: 555, userInfo: nil)
        let service = MockedRequestServiceAdapter(error: error)
        sut = PullRequestsServiceWorker(service: service)
        let expectation = XCTestExpectation()
        var expectedError: Error?

        // WHEN

        sut.getPullRequests(
            in: "anyrepo",
            owner: "anyone",
            page: 1,
            onCompletion: { _ in
                XCTFail("Unexpected error. It shout get a fail")
                expectation.fulfill()
            },

            onError: {
                expectedError = $0
                expectation.fulfill()
            }
        )

        wait(for: [expectation], timeout: 10.0)

        //THEN

        let collectedError = expectedError as NSError?
        XCTAssertEqual(collectedError?.code, 555)
        XCTAssertEqual(collectedError?.domain, "Expected error")
    }

    func testGetPullRequests__whenMakeRequest__itHasSuccess() {

        // GIVEN

        let service = MockedRequestServiceAdapter(data: Fixture.PullRequestsList.data)
        sut = PullRequestsServiceWorker(service: service)
        let expectation = XCTestExpectation()
        var elements: [PullRequest] = []

        let expectedResult : [PullRequest] = [
            .fixture(title: "First PR",
                     createdAt: "2011-01-26T00:00:00Z",
                     body: "Just a First PR",
                     htmlUrl: "https://github.com/",
                     user: .fixture(login: "user01", avatarUrl: "https://github.com/images/user01.gif")),
            .fixture(title: "Second PR",
                     createdAt: "2011-01-26T00:00:00Z",
                     body: "Just a Second PR",
                     htmlUrl: "https://github.com/",
                     user: .fixture(login: "user02", avatarUrl: "https://github.com/images/user02.gif"))
        ]

        // WHEN

        sut.getPullRequests(
            in: "anyrepo",
            owner: "anyone",
            page: 1,
            onCompletion: { repositories in
                elements = repositories
                expectation.fulfill()
            },

            onError: { _ in
                expectation.fulfill()
            }
        )

        wait(for: [expectation], timeout: 10.0)

        //THEN

        XCTAssertEqual(expectedResult, elements)
    }

}
