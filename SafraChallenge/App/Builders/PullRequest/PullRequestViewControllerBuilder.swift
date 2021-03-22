//
//  PullRequestViewControllerBuilder.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 14/03/21.
//

import UIKit

class PullRequestViewControllerBuilder {
    static func make(router: PullRequestRouter) -> UIViewController {

        let viewController = PullRequestViewController(nibName: nil, bundle: nil)
        
        let manager = GithubPullsRequestsManager()
        let interactor = GithubPullRequestsInteractorBuilder.make(manager: manager)
        let presenter = PullRequestPresenterBuilder.make(interactor: interactor, router: router)
        
        interactor.output = presenter
        presenter.output = viewController
        presenter.repository = router.repository
        viewController.presenter = presenter
        
        return viewController
    }
}
