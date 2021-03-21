//
//  PullRequestPresenterBuilder.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 14/03/21.
//

import Foundation

class PullRequestPresenterBuilder {
    static func make(interactor: GithubPullRequestsInteractorInput, router: PullRequestRouter) -> PullRequestsPresenter {
        let presenter = PullRequestsPresenter(interactor: interactor, router: router)
        
        return presenter
    }
}
