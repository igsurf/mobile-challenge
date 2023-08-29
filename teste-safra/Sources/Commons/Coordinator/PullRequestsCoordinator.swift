//
//  PullRequestsCoordinator.swift
//  teste-safra
//
//  Created by Gabriel Sousa on 12/04/21.
//

import UIKit

class PullRequestsCoordinator {

    // MARK: - Constants

    private let kStoryboardName = "PullRequests"

    // MARK: - Private Properties

    private let viewModel: PullRequestsViewModel
    private let repositoryName: String

    // MARK: - Life Cycle

    init(viewModel: PullRequestsViewModel, repositoryName: String) {
        self.viewModel = viewModel
        self.repositoryName = repositoryName
    }
}

// MARK: - Coordinator Implementation

extension PullRequestsCoordinator: BaseCoordinator {
    func start(navigationController: UINavigationController?) {
        let storyboard = UIStoryboard(name: kStoryboardName, bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() as? PullRequestsViewController else {
            return
        }
        controller.navigationController?.clearNavigation()
        controller.setupController(viewModel: viewModel, repositoryName: repositoryName)
        DispatchQueue.main.async {
            navigationController?.pushViewController(controller,
                                                     animated: true)
        }
    }
}
