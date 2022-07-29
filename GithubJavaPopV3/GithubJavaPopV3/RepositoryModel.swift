//
//  RepositoryModel.swift
//  GithubJavaPopV3
//
//  Created by Suh on 05/07/22.
//

import Foundation

protocol RepositoryModelDelegate: AnyObject {
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
        service.fetchRepositories(
            page: page,
            onComplete: { [weak self] repositories in
                self?.repositories.append(contentsOf: repositories.items)
                self?.delegate?.didUpdateRepositories()
            },
            onError: {_ in  // error
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
        .fixture(
            name: "Fabricio Robrigues Santos",
            description: "Geralmente são pessoas que gostam de ajudar os outros e reunir os amigos...",
            stargazersCount: 23, forks: 656, owner: Owner.fixture(avatarUrl: "placeholder.png", login: "Dede.EXE"))
        ]
}
#endif
