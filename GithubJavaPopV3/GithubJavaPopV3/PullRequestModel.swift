//
//  PullRequestModel.swift
//  GithubJavaPopV3
//
//  Created by Suh on 06/07/22.
//

import Foundation

protocol PullRequestModelDelegate: AnyObject {
    func didUpdatePulls()
    func didErrorPulls()
}

class PullRequestModel {
    private(set) var pulls: [PullRequest]
    private var service: PullRequestService
    var repository: String
    var owner: String
    weak var delegate: PullRequestModelDelegate?
    
    init(service: PullRequestService = PullRequestService(), repository: String, owner: String) {
        pulls = []
        self.service = service
        self.repository = repository
        self.owner = owner
    }
    
    func fetchPullRequest() {
        //pulls = mockPullRequest()
        service.fetchPullRequest(
            repository: repository,
            owner: owner
        ) { pulls in
            self.pulls = pulls ?? []
            self.delegate?.didUpdatePulls()
        } onError: { error in
            self.delegate?.didErrorPulls()
        }

        
    }
}

#if DEBUG
private func mockPullRequest() -> [PullRequest] {
    return [
        .fixture(),
        .fixture(),
        .fixture(),
        .fixture(),
        .fixture()
    ]
}
#endif
