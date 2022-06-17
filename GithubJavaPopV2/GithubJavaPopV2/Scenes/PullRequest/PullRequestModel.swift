//
//  PullRequestModel.swift
//  GithubJavaPopV2
//
//  Created by Suh on 14/06/22.
//

import Foundation

protocol PullRequestModalDelegate: AnyObject {
    func didupdatePullRequests()
}

class PullRequestModel {
    
    // MARK: - Properties
    private(set) var pullRequests: [PullRequest] = []
    let owner: String
    let repository: String
    weak var delegate: PullRequestModalDelegate?
    
    // MARK: - Initializer
    init(owner: String, repository: String) {
        self.owner = owner
        self.repository = repository
    }
    
    // MARK: - Methods
    func fetchPullRequests() {
        //pullRequests = mockPullRequeste()
        REST.loadPullRequest(owner: owner, repository: repository) { [weak self] (pullRequests) in
            DispatchQueue.main.async {
                self?.pullRequests = pullRequests ?? []
                self?.delegate?.didupdatePullRequests()
            }
           
        }
    }
}

private func mockPullRequeste() -> [PullRequest] {
    return [
        .fixture(),
        .fixture(),
        .fixture(title: "terminating with uncaught e", body: "no segue with identifier PullRequestViewController terminating with uncaught exception of type NSException CoreSimulator 783.5 - Device: iPhone 11", user: Owner.fixture(), createdAt: "24-23-2020"),
        .fixture(),
        .fixture(),
        .fixture(),
        .fixture()
    ]
}
