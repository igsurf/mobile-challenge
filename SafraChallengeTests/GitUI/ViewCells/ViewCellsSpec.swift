//
//  ViewCellsSpec.swift
//  SafraChallengeTests
//
//  Created by Ruan Gustavo de Oliveira on 17/03/21.
//

import Foundation
import Quick
import Nimble
@testable import SafraChallenge

class ViewCellsSpec: QuickSpec {
    override func spec() {
        describe("Testing GitUI") {
            context("View Cells") {
                it("Repositories") {
                    let cell = RepositoryViewCell()
                    cell.setup(repository: RepositoryView())
                    expect(cell).toNot(beNil())
//                    expect(cell)
                }
                
                it("PullRequests") {
                    let cell = PullRequestViewCell()
                    cell.setUp(pullrequest: PullRequestView())
                    expect(cell).toNot(beNil())
                }
            }
        }
    }
}
