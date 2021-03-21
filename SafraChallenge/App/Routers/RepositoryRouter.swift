//
//  RepositoryRouter.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 02/03/21.
//

import UIKit

class RepositoryRouter {
    var navigationController: UINavigationController?
    
    func present(in window: UIWindow) {
        window.makeKeyAndVisible()
        guard let viewController = RepositoriesViewControllerBuilder.make(router: self) else { return }
        navigationController = UINavigationController(rootViewController: viewController)
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                              NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.backgroundColor = UIColor.githubBlack
        navigationController?.navigationBar.barTintColor = UIColor.githubBlack
        navigationController?.navigationBar.tintColor = UIColor.white
        
        window.rootViewController = navigationController
    }
    
    func presentPullRequests(repository: RepositoryView) {
        
        guard let navigationController = self.navigationController else { return }
        PullRequestRouter().present(navigationController: navigationController, repository: repository)
    }
}
