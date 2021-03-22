//
//  GithubAPISpec.swift
//  SafraChallengeTests
//
//  Created by Ruan Gustavo de Oliveira on 15/03/21.
//

import Foundation
import Quick
import Nimble
@testable import SafraChallenge
 
class GithubAPISpec: QuickSpec {
    
    override func spec() {
        describe("Test GithubAPI Requests") {
            context("Requesting GithubAPI") {
                it("Listing Repositories") {
                    waitUntil(timeout: DispatchTimeInterval.seconds(30)) { done in
                        GithubAPI.instance.getRepositoriesByLanguage(language: "JAVA", page: 1, completion: { repositories in
                            expect(repositories).toNot(beNil())
                            expect(repositories).to(beAKindOf(GithubRepositoriesResponseModel.self))
                            done()
                        })
                    }
                }
                it("Listing Pull Requests") {
                    waitUntil(timeout: DispatchTimeInterval.seconds(30)) { done in
                        GithubAPI.instance.getPullsRequest(url: "https://api.github.com/repos/spring-projects/spring-boot/pulls", completion: { pullrequests in
                            expect(pullrequests).toNot(beNil())
                            expect(pullrequests).to(beAKindOf([PullRequestResponseModel].self))
                            done()
                        })
                    }
                }
            }
        }
    }
}
