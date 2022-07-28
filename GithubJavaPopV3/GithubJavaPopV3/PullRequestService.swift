//
//  PullRequestService.swift
//  GithubJavaPopV3
//
//  Created by Suh on 11/07/22.
//

import Foundation

class PullRequestService {
    private var network: Network
    
    init(network: Network = Network.shared) {
        self.network = network
    }
    
    func fetchPullRequest(
        repository: String,
        owner: String,
        onComplete: @escaping ([PullRequest]?) -> Void,
        onError: @escaping (Error) -> Void
    ) {
        let request = Request.init(
            baseURL: Config.baseURL,
            path: "repos/" + owner + "/" + repository + "/pulls",
            method: RequestMethod.get)
        
        network.request(request: request, returning: [PullRequest].self) { result in
            switch result {
            case .failure(let error):
                onError(error)
            case .success(let pullRequest):
                onComplete(pullRequest)
            }
        }
    }
    
}
