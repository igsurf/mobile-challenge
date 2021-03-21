//
//  GithubRepositoriesInteractorBuilder.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 22/02/21.
//

import Foundation

class GithubRepositoriesInteractorBuilder {
    static func make(manager: GithubRepositoriesManagerInput) -> GithubRepositoriesInteractor {
        
        return GithubRepositoriesInteractor(manager: manager)
    }
}
