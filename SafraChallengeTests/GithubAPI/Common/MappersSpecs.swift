//
//  MappersSpecs.swift
//  SafraChallengeTests
//
//  Created by Ruan Gustavo de Oliveira on 17/03/21.
//

import Foundation
import Quick
import Nimble
@testable import SafraChallenge

class MappersSpecs: QuickSpec {
    override func spec() {
        describe("Testing Mappers") {
            context("Responses Mapper") {
                it("Repository Decode Dictionary to Reponse Model") {
                    var dic = Dictionary<String, Any>()
                    dic["total_count"] = 0
                    dic["incomplete_results"] = false
                    dic["items"] = []
                    
                    let reponseModel = GithubAPIMapper.decode(repositories: dic)
                    expect(reponseModel).toNot(beNil())
                    expect(reponseModel).to(beAKindOf(GithubRepositoriesResponseModel.self))
                }
                
                it("PullRequests Decode Dictionary to Reponse Model") {
                    let dic = [Dictionary<String, Any>]()
                    
                    let reponseModel = GithubAPIMapper.decode(pullRequests: dic)
                    expect(reponseModel).toNot(beNil())
                    expect(reponseModel).to(beAKindOf([PullRequestResponseModel].self))
                }
            }
            context("View Mapper") {
                it("Repository Decode Reponse Model to View Model") {
                    let reponse = GithubObjectMapper.instance.parse(from: GithubRepositoriesResponseModel())
                    expect(reponse).toNot(beNil())
                    expect(reponse).to(beAKindOf([RepositoryView].self))
                }
                
                it("PullRequests ResponseModel to View Model") {
                    let reponseModel = GithubObjectMapper.instance.parse(from: [PullRequestResponseModel]())
                    expect(reponseModel).toNot(beNil())
                    expect(reponseModel).to(beAKindOf([PullRequestResponseModel].self))
                }
            }
        }
    }
}
