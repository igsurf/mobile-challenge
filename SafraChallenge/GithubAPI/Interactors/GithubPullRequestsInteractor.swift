//
//  GithubPullRequestsInteractor.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 27/02/21.
//

import Foundation

protocol GithubPullRequestsInteractorInput {
    func fetch(url: String, repository: RepositoryView)
}

protocol GithubPullRequestsInteractorOutput: class {
    func fetched(pullRequests: [PullRequestView])
}

class GithubPullRequestsInteractor: GithubPullRequestsInteractorInput {
    weak var output: GithubPullRequestsInteractorOutput?
    private var manager: GithubPullsRequestsManager
    
    private var githubPullRequests: [PullRequestView] = []
    
    init(manager: GithubPullsRequestsManager) {
        self.manager = manager
    }
    
    func fetch(url: String, repository: RepositoryView) {
        manager.get(url: url, completion: { pullRequests in
            if let prs = pullRequests {
                self.githubPullRequests = GithubObjectMapper.instance.parse(from: prs)
                DatabaseController.instance.updateRepository(repository: repository, pullRequests: self.githubPullRequests)
            } else {
                self.githubPullRequests = repository.pullRequests
            }
            
            self.output?.fetched(pullRequests: self.githubPullRequests)
        })
    }
}
