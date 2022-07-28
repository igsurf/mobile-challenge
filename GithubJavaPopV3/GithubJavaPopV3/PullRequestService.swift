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
        
        network.requestData(using: request) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let pullRequest = try decoder.decode([PullRequest].self, from: data)
                    onComplete(pullRequest)
                } catch {
                    onError(error)
                }
            case .failure(let error):
                onError(error)
            }
        }
    }
    
}
