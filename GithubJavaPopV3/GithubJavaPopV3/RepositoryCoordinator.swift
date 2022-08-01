//
//  RepositoryCoordinator.swift
//  GithubJavaPopV3
//
//  Created by Suh on 29/07/22.
//

// swiftlint:disable line_length

import Foundation
import UIKit

class RepositoryCoordinator: Coordinator {
    var navigationController: UINavigationController
    private var viewController: RepositoryViewController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let repositoryViewController = makeRepositoryViewController()
        self.viewController = repositoryViewController
        navigationController.pushViewController(repositoryViewController, animated: true)
    }

    private func makeRepositoryViewController() -> RepositoryViewController {
        let storyboard = UIStoryboard.init(name: "RepositoryStoryboard", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "RepositoryViewController") as? RepositoryViewController else {
            fatalError()
        }

        let model = RepositoryModel()
        model.delegate = viewController
        viewController.model = model
        viewController.coordinator = self
        return viewController
    }

}
