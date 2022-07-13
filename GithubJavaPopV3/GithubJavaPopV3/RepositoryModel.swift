//
//  RepositoryModel.swift
//  GithubJavaPopV3
//
//  Created by Suh on 05/07/22.
//

import Foundation

protocol RepositoryModelDelegate:AnyObject {
    func didUpdateRepositories()
    func didErrorRepositories()
}

class RepositoryModel {
    
    private(set) var repositories: [Repository]
    weak var delegate: RepositoryModelDelegate?
    private let service: RepositoryService
    
    init(service: RepositoryService = RepositoryService()) {
        repositories = []
        self.service = service
    }
    
    func fetchRepositories() {
        //repositories = mockRepository()
//        REST.loadRepositories { [weak self ] (repositories) in
//            self?.repositories = repositories?.items ?? []
//            self?.delegate?.didUpdateRepositories()
//        }
        service.fetchRepositories { [weak self] repositories in
            self?.repositories = repositories.items
            self?.delegate?.didUpdateRepositories()
        } onError: { error in
            self.delegate?.didErrorRepositories()
        }

    }
    
}

#if DEBUG
private func mockRepository() -> [Repository] {
    return [
        .fixture(),
        .fixture(),
        .fixture(name: "Fabricio Robrigues Santos", description: "Geralmente são pessoas solícitas, que gostam de ajudar os outros e reunir os amigos. Seu senso de justiça também é bastante aflorado. As pessoas com ascendente em Libra podem ser um pouco narcisistas. Sua visão romantizada da vida costuma ser mais marcante, do que a de pessoas com sol no signo de Libra", stargazersCount: 23, forks: 656, owner: Owner.fixture(avatarUrl: "placeholder.png", login: "Dede.EXE"))
        ]
}
#endif
