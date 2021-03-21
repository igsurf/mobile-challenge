//
//  PullRequestRouter.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 14/03/21.
//

import UIKit

class PullRequestRouter {
    var navigationController: UINavigationController?
    var repository: RepositoryView?
    
    func present(navigationController: UINavigationController, repository: RepositoryView) {
        self.repository = repository
        navigationController.pushViewController(PullRequestViewControllerBuilder.make(router: self), animated: true)
    }
}
