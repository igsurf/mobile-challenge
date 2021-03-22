//
//  GithubPullsRequestsManager.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 27/02/21.
//

import Foundation

typealias GithubPullsRequestsHandler = (([PullRequestResponseModel]?) -> Void)

protocol GithubPullsRequestsManagerInput {
    func get(url: String, completion: @escaping GithubPullsRequestsHandler)
}

public class GithubPullsRequestsManager: GithubPullsRequestsManagerInput {
    var object: [PullRequestResponseModel]?
    
    func get(url: String, completion: @escaping GithubPullsRequestsHandler) {
        GithubAPI.instance.getPullsRequest(url: url, completion: { object in
            self.object = object
            completion(self.object)
        })
    }
}
