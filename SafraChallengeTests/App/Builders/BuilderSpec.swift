//
//  BuilderSpec.swift
//  SafraChallengeTests
//
//  Created by Ruan Gustavo de Oliveira on 17/03/21.
//

import Foundation
import Quick
import Nimble
@testable import SafraChallenge

class BuilderSpec: QuickSpec {
    override func spec() {
        describe("Testing App Builders") {
            context("Repositories") {
                it("Presenter Builder") {
                    let manager = GithubRepositoriesManager()
                    let interactor = GithubRepositoriesInteractor(manager: manager)
                    let router = RepositoryRouter()
                    let presenter = RepositoriesPresenterBuilder.make(interactor: interactor, router: router)
                    expect(presenter).toNot(beNil())
                }
                it("ViewController Builder") {
                    let router = RepositoryRouter()
                    let viewController = RepositoriesViewControllerBuilder.make(router: router)
                    expect(viewController).toNot(beNil())
                }
            }
            context("PullRequests") {
                it("Presenter Builder") {
                    let manager = GithubPullsRequestsManager()
                    let interactor = GithubPullRequestsInteractor(manager: manager)
                    let router = PullRequestRouter()
                    let presenter = PullRequestPresenterBuilder.make(interactor: interactor, router: router)
                    expect(presenter).toNot(beNil())
                }
                it("ViewController Builder") {
                    let router = PullRequestRouter()
                    let viewController = PullRequestViewControllerBuilder.make(router: router)
                    expect(viewController).toNot(beNil())
                }
            }
        }
    }
}
