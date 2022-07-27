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
    private var page: Int = 0
    
    init(service: RepositoryService = RepositoryService()) {
        repositories = []
        self.service = service
    }
    
    func fetchRepositories() {
        page += 1
        service.fetchRepositories (
            page: page,
            onComplete: { [weak self] repositories in
                self?.repositories.append(contentsOf: repositories.items)
                self?.delegate?.didUpdateRepositories()
            },
            onError: { error in
                self.delegate?.didErrorRepositories()
            }
        )

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
