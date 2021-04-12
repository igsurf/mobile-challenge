//
//  PullRequestsCellViewModel.swift
//  teste-safraTests
//
//  Created by Gabriel Sousa on 12/04/21.
//

import XCTest
@testable import teste_safra

class PullRequestsCellViewModel: XCTestCase {

    // MARK: - Private Properties

    private var viewModel: PullRequestCellViewModel?

    override func setUp() {
        super.setUp()
        let user = Owner(login: "gabriel",
                         avatarURL: "gabriel",
                         name: "gabriel")

        let model = PullRequest(state: "open",
                                title: "titulo",
                                user: user,
                                body: "body",
                                htmlURL: "url")

        viewModel = PullRequestCellViewModel(model: model,
                                             service: MockServices())
    }

    // MARK: - Tests

    func testTitle() {
        let expected = "titulo"
        XCTAssertEqual(expected, viewModel?.title)
    }

    func testBody() {
        let expected = "body"
        XCTAssertEqual(expected, viewModel?.body)
    }

    func testUserName() {
        let expected = "gabriel"
        XCTAssertEqual(expected, viewModel?.userName)
    }

    func testUserFullName() {
        let expected = "gabriel"
        var result = String.empty
        let expectation = self.expectation(description: "name")
        viewModel?.getUserFullName(completion: { name in
            result = name ?? .empty
            expectation.fulfill()
        })
        waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error)
            XCTAssertEqual(expected, result)
        }
    }
}
