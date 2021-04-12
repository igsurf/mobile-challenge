//
//  PullRequestsViewModelTests.swift
//  teste-safraTests
//
//  Created by Gabriel Sousa on 12/04/21.
//

import XCTest
@testable import teste_safra

class PullRequestsViewModelTests: XCTestCase {

    // MARK: - Private Properties

    private var viewModel: PullRequestsViewModel?

    override func setUp() {
        super.setUp()
        let user = Owner(login: "gabriel",
                         avatarURL: "gabriel",
                         name: "gabriel")
        let lists = [
            PullRequest(state: "open",
                        title: "title",
                        user: user,
                        body: "body",
                        htmlURL: "http://google.com"),
            PullRequest(state: "closed",
                        title: "title2",
                        user: user,
                        body: "body2",
                        htmlURL: "http://google2.com")
        ]
        viewModel = PullRequestsViewModel(model: lists)
    }

    // MARK: - Tests

    func testPullRequestsCount() {
        let expected = 2
        XCTAssertEqual(expected, viewModel?.pullRequestsCount)
    }

    func testGetPullRequestUrl() {
        let expected = URL(string: "http://google.com")
        XCTAssertEqual(expected, viewModel?.getPullRequestURL(position: 0))
    }

    func testOpenClosedTitle() {
        let expected = "1 abertos / 1 fechados"
        XCTAssertEqual(expected, viewModel?.openClosedTitle.string)
    }
}
