@testable import CoreArchitecture
import CoreInterfaces
import DDXNetwork
import XCTest

class RepositoriesServiceWorkerTests: XCTestCase {

    var sut: RepositoriesServiceWorker!
    var service: RequestServicePort!

    func testGetRepositories__whenMakeRequest_itFails() {

        // GIVEN

        let error = NSError(domain: "Expected error", code: 555, userInfo: nil)
        let service = MockedRequestServiceAdapter(error: error)
        sut = RepositoriesServiceWorker(service: service)
        let expectation = XCTestExpectation()

        // WHEN

        sut.getRepositories(
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

    func testGetRepositories__whenMakeRequest_itHasSuccess() {

        // GIVEN

        let service = MockedRequestServiceAdapter(data: Fixture.RepositoriesList.data)
        sut = RepositoriesServiceWorker(service: service)
        let expectation = XCTestExpectation()

        let expectedResult : [Repository] = [
            .fixture(id: 1,
                     name: "repo01",
                     description: "first repo",
                     forksCount: nil,
                     stargazersCount: nil,
                     owner: .fixture(login: "login01", avatarUrl: "url01")
            ),
            .fixture(id: 2,
                     name: "repo02",
                     description: "second repo",
                     forksCount: nil,
                     stargazersCount: nil,
                     owner: .fixture(login: "login02", avatarUrl: "url02")
            ),
            .fixture(id: 3,
                     name: "repo03",
                     description: "third repo",
                     forksCount: nil,
                     stargazersCount: nil,
                     owner: .fixture(login: "login03", avatarUrl: "url03")
            )
        ]

        // WHEN

        sut.getRepositories(
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
