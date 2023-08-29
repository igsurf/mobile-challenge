//
//  RepositoryCellViewModelTests.swift
//  teste-safraTests
//
//  Created by Gabriel Sousa on 12/04/21.
//

import XCTest
@testable import teste_safra

class RepositoryCellViewModelTests: XCTestCase {

    // MARK: - Private Properties

    private var viewModel: RepositoryCellViewModel?

    override func setUp() {
        super.setUp()
        let user = Owner(login: "gabriel",
                         avatarURL: "gabriel",
                         name: "https://google.com")
        
        let repo = Repository(name: "nome",
                              fullName: "nome inteiro",
                              owner: user,
                              itemDescription: "desc",
                              stargazersCount: 10,
                              forksCount: 5,
                              forks: 5,
                              pullsURL: "url")
        viewModel = RepositoryCellViewModel(model: repo,
                                            service: MockServices())
    }

    // MARK: - Tests

    func testStarCountsText() {
        let expected = "10"
        XCTAssertEqual(expected, viewModel?.starCountsText)
    }

    func testRepositoryName() {
        let expected = "nome"
        XCTAssertEqual(expected, viewModel?.repositoryName)
    }

    func testRepositoryDesc() {
        let expected = "desc"
        XCTAssertEqual(expected, viewModel?.repositoryDesc)
    }

    func testForkCountText() {
        let expected = "5"
        XCTAssertEqual(expected, viewModel?.forksCountText)
    }

    func testUserName() {
        let expected = "gabriel"
        XCTAssertEqual(expected, viewModel?.username)
    }
}
