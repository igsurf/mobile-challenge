//
//  RoutersSpec.swift
//  SafraChallengeTests
//
//  Created by Ruan Gustavo de Oliveira on 17/03/21.
//

import Foundation
import Quick
import Nimble
@testable import SafraChallenge

class RepositoryRouterMock: RepositoryRouter {
    var presentTest: Bool = false
    var presentPullRequestsTest: Bool = false
    
    override func present(in window: UIWindow) {
        super.present(in: window)
        self.presentTest = true
    }
    override func presentPullRequests(repository: RepositoryView) {
        super.presentPullRequests(repository: repository)
        self.presentPullRequestsTest = true
    }
}

class PullRequestRouterMock: PullRequestRouter {
    var presentTest: Bool = false

    override func present(navigationController: UINavigationController, repository: RepositoryView) {
        super.present(navigationController: navigationController, repository: repository)
        self.presentTest = true
    }
}

class RoutersSpec: QuickSpec {

    override func spec() {
        describe("Testing App Routers") {
            context("Repository") {
                it("Router") {
                    let router = RepositoryRouterMock()
                    router.present(in: UIWindow())
                    router.presentPullRequests(repository: RepositoryView())
                    expect(router).toNot(beNil())
                    expect(router.presentTest).to(beTrue())
                    expect(router.presentTest).to(beTrue())
                    
                }
            }
            context("PullRequest") {
                it("Router") {
                    let router = PullRequestRouterMock()
                    router.present(navigationController: UINavigationController(), repository: RepositoryView())
                    expect(router).toNot(beNil())
                    expect(router.presentTest).to(beTrue())
                }
            }
        }
    }
}
