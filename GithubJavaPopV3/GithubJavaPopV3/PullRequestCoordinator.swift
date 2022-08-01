//
//  PullRequestCoordinator.swift
//  GithubJavaPopV3
//
//  Created by Suh on 01/08/22.
//

import Foundation
import UIKit
import SafariServices

class PullRequestCoordinator: Coordinator {
    var navigationController: UINavigationController
    private var viewController: PullRequestViewController?
    private let repository: String
    private let owner: String

    init(repository: String, owner: String, navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.repository = repository
        self.owner = owner
    }

    func start() {
        let pullRequestViewController = makePullRequest()
        self.viewController = pullRequestViewController
        navigationController.pushViewController(pullRequestViewController, animated: true)
    }

    private func makePullRequest() -> PullRequestViewController {
        let storyboard = UIStoryboard.init(name: "PullRequestStoryboard", bundle: nil)
        guard let viewController = storyboard
            .instantiateViewController(withIdentifier: "PullRequestViewController") as? PullRequestViewController else {
            fatalError()
        }
        let model = PullRequestModel(repository: repository, owner: owner)
        viewController.model = model
        model.delegate = viewController
        viewController.delegate = self
        return viewController
    }

}

extension PullRequestCoordinator: PullRequestViewControllerDelegate {
    func showPullRequestDetails(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        let pullRequestViewController = SFSafariViewController(url: url)
        navigationController.pushViewController(pullRequestViewController, animated: true)
    }
}
