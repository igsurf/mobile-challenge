//
//  SceneDelegate.swift
//  GithubJavaPopV3
//
//  Created by Suh on 04/07/22.
//

// swiftlint:disable line_length

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        let navigationController = UINavigationController()
        coordinator = AppCoordinator(window: window, navigationController: navigationController)
        coordinator?.start()

    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }

//    func respositoriesScene() -> UIViewController {
//        let viewController = RepositoryViewController.create()
//        let navigator = UINavigationController(rootViewController: viewController)
//        return navigator
//    }

//    func pullRequestScene() -> UIViewController {
//        let viewController = PullRequestViewController.create()
//        let navigator = UINavigationController(rootViewController: viewController)
//        return navigator
//    }
}
