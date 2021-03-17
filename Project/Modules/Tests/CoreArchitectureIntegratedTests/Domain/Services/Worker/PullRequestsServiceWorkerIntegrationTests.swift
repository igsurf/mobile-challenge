@testable import CoreArchitecture
import CoreInterfaces
import DDXNetwork
import XCTest

class PullRequestsServiceWorkerIntegrationTests: XCTestCase {

    var sut: PullRequestsServiceWorker!
    var service: RequestServicePort!

    ///
    /// Testes if endpoint to get the list of Repositories is working and giving back a valida structure of data
    ///

    func testGetPullRequests__whenRequestRepositories__RepositoriesCountIsEqualThree() {
        //GIVEN
        sut = PullRequestsServiceWorker(service: RequestServiceAdapter(), pageSize: 3)
        let expectation = XCTestExpectation()
        var elements: [PullRequest] = []

        //WHEN

        sut.getPullRequests(
            in: "Alamofire",
            owner: "Alamofire",
            page: 1,
            onCompletion: {
                elements = $0
                expectation.fulfill()
            },
            onError: { error in
                XCTFail("Unexpected error. It shout be success: \(error.localizedDescription)")
                expectation.fulfill()
            }
        )

        //THEN

        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(elements.count, 3)
    }
}
