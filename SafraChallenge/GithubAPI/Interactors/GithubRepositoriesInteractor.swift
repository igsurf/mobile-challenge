//
//  GithubRepositoriesInteractor.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 22/02/21.
//

import Foundation

protocol GithubRepositoriesInteractorInput {
    func fetch(language: String, page: Int)
}

protocol GithubRepositoriesInteractorOutput: class {
    func fetched(repositories: [RepositoryView])
}

class GithubRepositoriesInteractor: GithubRepositoriesInteractorInput {
    weak var output: GithubRepositoriesInteractorOutput?
    private var manager: GithubRepositoriesManagerInput
    
    private var githubRepositories: [RepositoryView] = []
    
    init(manager: GithubRepositoriesManagerInput) {
        self.manager = manager
    }
    
    func fetch(language: String,page: Int) {
        manager.get(language: language, page: page, completion: { repositories in
            
            if let repos = repositories {
                self.githubRepositories = GithubObjectMapper.instance.parse(from: repos)
                DatabaseController.instance.set(repositories: self.githubRepositories)
            } else {
                self.githubRepositories = DatabaseController.instance.getRepositories()
            }
            self.output?.fetched(repositories: self.githubRepositories)
        })
    }
    
    
}
