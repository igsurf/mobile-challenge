//
//  RepositoriesPresenterBuilder.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 10/03/21.
//

import Foundation

class RepositoriesPresenterBuilder {
    
    static func make(interactor: GithubRepositoriesInteractorInput, router: RepositoryRouter) -> RepositoriesPresenter {
        let presenter = RepositoriesPresenter(interactor: interactor, router: router)
        
        return presenter
    }
}
