//
//  GithubManagersSpec.swift
//  SafraChallengeTests
//
//  Created by Ruan Gustavo de Oliveira on 16/03/21.
//

import Foundation
import Quick
import Nimble
@testable import SafraChallenge

class GithubManagersSpec: QuickSpec {
    
    override func spec() {
        describe("Test Github Managers") {
            context("Repositories Github") {
                it("Function Get") {
                    waitUntil(timeout: DispatchTimeInterval.seconds(30)) { done in
                        let manager = GithubRepositoriesManager()
                        manager.get(language: "JAVA", page: 1, completion: { repositories in
                            expect(repositories).toNot(beNil())
                            expect(manager.object).toNot(beNil())
                            expect(repositories).to(beAKindOf(GithubRepositoriesResponseModel.self))
                            done()
                        })
                    }
                }
            }
            context("Pull Requests Github") {
                it("Function Get") {
                    waitUntil(timeout: DispatchTimeInterval.seconds(30)) { done in
                        let manager = GithubPullsRequestsManager()
                        let urlPrs = "https://api.github.com/repos/spring-projects/spring-boot/pulls"
                        manager.get(url: urlPrs, completion: { pullrequests in
                            expect(pullrequests).toNot(beNil())
                            expect(pullrequests?.count).to(beGreaterThan(0))
                            expect(manager.object).toNot(beNil())
                            expect(manager.object?.count).to(beGreaterThan(0))
                            expect(pullrequests).to(beAKindOf([PullRequestResponseModel].self))
                            done()
                        })
                    }
                }
            }
        }
    }
}
