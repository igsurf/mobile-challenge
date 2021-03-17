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
        var elements: [Repository] = []

        //WHEN
        sut.getRepositories(
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
        XCTAssertGreaterThan(elements.capacity, 0)
    }
}
