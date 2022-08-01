//
//  AppCoordinator.swift
//  GithubJavaPopV3
//
//  Created by Suh on 29/07/22.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    let window: UIWindow
    var childCoordinator: Coordinator?

    init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
    }

    func start() {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        startRepository(navigationController)
    }

    fileprivate func startRepository(_ navigationController: UINavigationController) {
        let repositoryCoordinator = RepositoryCoordinator(navigationController: navigationController)
        repositoryCoordinator.start()
        self.childCoordinator = repositoryCoordinator
    }

}
