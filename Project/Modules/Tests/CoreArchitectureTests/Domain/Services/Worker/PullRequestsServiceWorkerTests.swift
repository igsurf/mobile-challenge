@testable import CoreArchitecture
import CoreInterfaces
import DDXNetwork
import XCTest

class PullRequestsServiceWorkerTests: XCTestCase {

    var sut: PullRequestsServiceWorker!
    var service: RequestServicePort!

    func testGetPullRequests__whenMakeRequest_itFails() {

        // GIVEN

        let error = NSError(domain: "Expected error", code: 555, userInfo: nil)
        let service = MockedRequestServiceAdapter(error: error)
        sut = PullRequestsServiceWorker(service: service)
        let expectation = XCTestExpectation()

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

                // THEN

                let error = $0 as NSError
                XCTAssertEqual(error.code, 555)
                XCTAssertEqual(error.domain, "Expected error")
                expectation.fulfill()
            }
        )

        wait(for: [expectation], timeout: 10.0)
    }

    func testGetPullRequests__whenMakeRequest_itHasSuccess() {

        // GIVEN

        let service = MockedRequestServiceAdapter(data: Fixture.PullRequestsList.data)
        sut = PullRequestsServiceWorker(service: service)
        let expectation = XCTestExpectation()

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
                // THEN

                XCTAssertEqual(repositories, expectedResult)
                expectation.fulfill()
            },

            onError: { _ in
                XCTFail("Unexpected error. It shout be success")
            }
        )

        wait(for: [expectation], timeout: 10.0)
    }

}
