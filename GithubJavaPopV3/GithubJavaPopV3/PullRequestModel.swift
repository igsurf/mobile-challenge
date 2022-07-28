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
    private var repository: String
    private var owner: String
    weak var delegate: PullRequestModelDelegate?
    private var page: Int = 0
    private var canLoad: Bool = true
    private var canGetMoreData: Bool = true
    
    init(service: PullRequestService = PullRequestService(), repository: String, owner: String) {
        pulls = []
        self.service = service
        self.repository = repository
        self.owner = owner
    }
    
    func fetchPullRequest() {
        guard canLoad, canGetMoreData else {
            return
        }
        
        canLoad = false
        page += 1
        
        service.fetchPullRequest(
            page: page,
            repository: repository,
            owner: owner
        ) { [weak self] pulls in
            self?.canLoad = true
            self?.canGetMoreData = false
            
            if let pulls = pulls, pulls.isEmpty == false {
                self?.pulls += pulls
                self?.delegate?.didUpdatePulls()
                self?.canGetMoreData = true
            }
        } onError: { [weak self] error in
            self?.canLoad = true
            self?.delegate?.didErrorPulls()
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
