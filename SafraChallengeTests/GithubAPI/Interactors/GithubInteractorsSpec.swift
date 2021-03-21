//
//  GithubInteractorsSpec.swift
//  SafraChallengeTests
//
//  Created by Ruan Gustavo de Oliveira on 16/03/21.
//

import Foundation
import Quick
import Nimble
@testable import SafraChallenge

class GithubInteractorsSpec: QuickSpec {
    var done: (() -> Void)?
    override func spec() {
        describe("Test Github Interactors") {
            context("Repositories Interactor") {
                it("Function Get") {
                    waitUntil(timeout: DispatchTimeInterval.seconds(30)) { done in
                        let manager = GithubRepositoriesManager()
                        let interactor = GithubRepositoriesInteractor(manager: manager)
                        interactor.output = self
                        
                        interactor.fetch(language: "JAVA", page: 1)
                        
                        self.done = done
                    }
                }
            }
            context("Pull Requests Interactor") {
                it("Function Fetch") {
                    waitUntil(timeout: DispatchTimeInterval.seconds(30)) { done in
                        let manager = GithubPullsRequestsManager()
                        let interactor = GithubPullRequestsInteractor(manager: manager)
                        interactor.output = self
                        let urlPrs = "https://api.github.com/repos/spring-projects/spring-boot/pulls"
                        interactor.fetch(url: urlPrs, repository: RepositoryView())
                        
                        self.done = done
                    }
                }
            }
        }
    }
}

extension GithubInteractorsSpec: GithubRepositoriesInteractorOutput, GithubPullRequestsInteractorOutput {
    func fetched(pullRequests: [PullRequestView]) {
        expect(pullRequests).toNot(beNil())
        expect(pullRequests.count).to(beGreaterThan(0))
        expect(pullRequests).to(beAKindOf([PullRequestView].self))
        if let mDone = self.done {
            mDone()
        }
    }
    
    func fetched(repositories: [RepositoryView]) {
        expect(repositories).toNot(beNil())
        expect(repositories.count).to(beGreaterThan(0))
        expect(repositories).to(beAKindOf([RepositoryView].self))
        if let mDone = self.done {
            mDone()
        }
    }
}
