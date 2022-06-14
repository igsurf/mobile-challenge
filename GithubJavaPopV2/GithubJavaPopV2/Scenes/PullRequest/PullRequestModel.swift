//
//  PullRequestModel.swift
//  GithubJavaPopV2
//
//  Created by Suh on 14/06/22.
//

import Foundation

class PullRequestModel {
    
    private(set) var pullRequests: [PullRequest] = []
    
    func fetchPullRequest() {
        pullRequests = mockPullRequeste()
        
    }
}

private func mockPullRequeste() -> [PullRequest] {
    return [
        .fixture(),
        .fixture(),
        .fixture(title: "terminating with uncaught e", body: "no segue with identifier PullRequestViewController terminating with uncaught exception of type NSException CoreSimulator 783.5 - Device: iPhone 11", user: Owner.fixture(), createdAt: "24-23-2020"),
        .fixture(),
        .fixture()
    ]
}
