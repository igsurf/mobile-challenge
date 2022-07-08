//
//  RepositoryModel.swift
//  GithubJavaPopV3
//
//  Created by Suh on 05/07/22.
//

import Foundation

protocol RepositoryModelDelegate:AnyObject {
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
//        REST.loadRepositories { [weak self ] (repositories) in
//            self?.repositories = repositories?.items ?? []
//            self?.delegate?.didUpdateRepositories()
//        }
        let request =  Request.init(
            baseURL: "https://api.github.com",
            path: "/search/repositories?q=language:Java&sort=stars&page=1",
            method: RequestMethod.get
        )
        Network.shared.requestData(using: request) { [ weak self ] data in
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let repository = try decoder.decode(Repositories.self, from: data)
                self?.repositories = repository.items
                self?.delegate?.didUpdateRepositories()
            } catch {
                print(error.localizedDescription)
            }
            print("Sucesso")
        } onError: { error in
            print("Error")
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
