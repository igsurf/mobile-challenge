//
//  RepositoryModel.swift
//  GithubJavaPopV2
//
//  Created by Suh on 10/06/22.
//

import Foundation

protocol RepositoryModelDelegate: AnyObject {
    func didUpdateRepositories()
}

class RepositoryModel {
    
    private(set) var repositories: [Repository]
    weak var delegate: RepositoryModelDelegate?
    
    init() {
        repositories = []
    }
    
    func fetchRepositories() {
        //repositories = mockRepository()
        REST.loadRepository { [weak self] (repositories) in
            self?.repositories = repositories?.items ?? []
            self?.delegate?.didUpdateRepositories()
        }
        
    }
    
}

private func mockRepository() -> [Repository] {
    return [
        .fixture(),
        .fixture(),
        .fixture(),
        .fixture(),
        .fixture(),
        .fixture(),
        .fixture(),
        .fixture(name: "joao", description: "kskjfhsi7tsegkfsge77trgao", stargazersCount: 23, forks: 23, owner: .fixture())
    ]
}
