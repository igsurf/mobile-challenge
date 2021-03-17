@testable import CoreArchitecture
import CoreInterfaces
import DDXNetwork
import XCTest

class RepositorieserviceWorkerIntegrationTests: XCTestCase {

    var sut: RepositoriesServiceWorker!
    var service: RequestServicePort!

    ///
    /// Testes if endpoint to get the list of Repositories is working and giving back a valida structure of data
    ///

    func testGetRepositories__whenRequestRepositories__RepositoriesCountIsGraterThanZero() {
        //GIVEN
        sut = RepositoriesServiceWorker(service: RequestServiceAdapter())
        let expectation = XCTestExpectation()

        //WHEN
        sut.getRepositories(
            page: 1,
            onCompletion: {
                //THEN
                XCTAssertGreaterThan($0.count, 0)
                expectation.fulfill()
            },
            onError: { _ in
                XCTFail("Unexpected error. It shout be success")
                expectation.fulfill()
            }
        )

        wait(for: [expectation], timeout: 10.0)
    }
}
