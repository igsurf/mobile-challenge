//
//  RepositoriesViewControllerBuilder.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 10/03/21.
//

import Foundation
import UIKit

class RepositoriesViewControllerBuilder {
    static func make(router: RepositoryRouter) -> UIViewController? {

        guard let viewController = UIStoryboard(name: "Main",
                                                bundle: nil)
            .instantiateViewController(identifier: "ViewController") as? ViewController else { return nil }
        
        let manager = GithubRepositoriesManager()
        let interactor = GithubRepositoriesInteractorBuilder.make(manager: manager)
        let presenter = RepositoriesPresenterBuilder.make(interactor: interactor, router: router)
        
        interactor.output = presenter
        presenter.output = viewController
        viewController.presenter = presenter
        
        return viewController
    }
}
