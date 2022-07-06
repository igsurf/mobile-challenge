//
//  PullRequestModel.swift
//  GithubJavaPopV3
//
//  Created by Suh on 06/07/22.
//

import Foundation


class PullRequestModel {
    private(set) var pulls: [PullRequest]
    
    init() {
        pulls = []
    }
    
    func fetchPullRequest() {
        pulls = mockPullRequest()
    }
}

private func mockPullRequest() -> [PullRequest] {
    return [
        .fixture(),
        .fixture(),
        .fixture()
        ]
    
}
