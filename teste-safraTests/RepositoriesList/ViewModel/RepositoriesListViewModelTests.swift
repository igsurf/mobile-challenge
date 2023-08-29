//
//  RepositoriesListViewModelTests.swift
//  teste-safraTests
//
//  Created by Gabriel Sousa on 12/04/21.
//

import XCTest
@testable import teste_safra

class RepositoriesListViewModelTests: XCTestCase {

    // MARK: - Private Properties
    
    private var viewModel: RepositoriesListViewModel?

    override func setUp() {
        super.setUp()
        viewModel = RepositoriesListViewModel(services: MockServices())
        viewModel?.getRepositoriesList(
            language: .kotlin,
            success: {
            },
            failure: { _ in
        })
    }

    // MARK: - Tests

    func testGetRepositoriesList() {
        var serviceError: Error?
        let expectation = self.expectation(description: "name")
        viewModel?.getRepositoriesList(
            language: .java,
            success: {
                expectation.fulfill()
            },
            failure: { error in
                serviceError = error
                expectation.fulfill()
            })
        waitForExpectations(timeout: 2) { error in
            XCTAssertNil(error)
            XCTAssertNil(serviceError)
        }
    }

    func testGetRepositoriesListNextPage() {
        var serviceError: Error?
        let expectation = self.expectation(description: "name")
        viewModel?.getRepositoriesListNextPage(
            success: {
                expectation.fulfill()
            },
            failure: { error in
                serviceError = error
                expectation.fulfill()
            })
        waitForExpectations(timeout: 2) { error in
            XCTAssertNil(error)
            XCTAssertNil(serviceError)
        }
    }

    func testGetSelectedRepositoryName() {
        let expected = "CS-Notes"
        XCTAssertEqual(expected, viewModel?.getSelectedRepositoryName(position: 0))
    }

    func testGetPullRequestList() {
        var serviceError: Error?
        let expectation = self.expectation(description: "name")
        viewModel?.getPullRequestsList(
            position: 0,
            success: { _ in
                expectation.fulfill()
            },
            failure: { error in
                serviceError = error
                expectation.fulfill()
            })
        waitForExpectations(timeout: 2) { error in
            XCTAssertNil(error)
            XCTAssertNil(serviceError)
        }
    }
}
