//
//  RepositoryCoordinator.swift
//  GithubJavaPopV3
//
//  Created by Suh on 29/07/22.
//

import Foundation
import UIKit

class RepositoryCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let repositoryViewController = RepositoryViewController()
        repositoryViewController.coordinator = self
        navigationController.pushViewController(repositoryViewController, animated: true)
    }
}
