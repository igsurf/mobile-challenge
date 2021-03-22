//
//  GithubPullRequestsInteractorBuilder.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 27/02/21.
//

import Foundation

class GithubPullRequestsInteractorBuilder {
    static func make(manager: GithubPullsRequestsManager) -> GithubPullRequestsInteractor {
        
        return GithubPullRequestsInteractor(manager: manager)
    }
}
