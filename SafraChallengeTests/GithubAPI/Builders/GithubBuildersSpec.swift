//
//  GithubBuildersSpec.swift
//  SafraChallengeTests
//
//  Created by Ruan Gustavo de Oliveira on 16/03/21.
//

import Foundation
import Quick
import Nimble
@testable import SafraChallenge

class GithubBuildersSpec: QuickSpec {
    
    override func spec() {
        describe("Test Github Builders") {
            context("Repositories Builder") {
                it("Function Make") {
                    let manager = GithubRepositoriesManager()
                    let interactor = GithubRepositoriesInteractorBuilder.make(manager: manager)
                    expect(interactor).toNot(beNil())
                    expect(interactor).to(beAKindOf(GithubRepositoriesInteractor.self))
                }
            }
            context("Pull Requests Bulder") {
                it("Function Make") {
                    let manager = GithubPullsRequestsManager()
                    let interactor = GithubPullRequestsInteractorBuilder.make(manager: manager)
                    expect(interactor).toNot(beNil())
                    expect(interactor).to(beAKindOf(GithubPullRequestsInteractor.self))
                }
            }
        }
    }
}
