//
//  ViewController.swift
//  GithubJavaPopV3
//
//  Created by Suh on 04/07/22.
//

// swiftlint:disable line_length

import UIKit

class RepositoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewLoading: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    var model: RepositoryModel?
    var repositories: [Repository] {
        model?.repositories ?? []
    }
    weak var coordinator: RepositoryCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetch()
    }

    private func fetch() {
        self.showLoading()
        self.model?.fetchRepositories()
    }

    private func showLoading() {
        self.loadingIndicator.startAnimating()
        self.viewLoading.isHidden = false
    }

    private func hideLoading() {
        self.loadingIndicator.stopAnimating()
        self.viewLoading.isHidden = true
    }

}

extension RepositoryViewController {
    static func create() -> RepositoryViewController {
        let storyboard = UIStoryboard.init(name: "RepositoryStoryboard", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "RepositoryViewController") as? RepositoryViewController else {
            fatalError()
        }

        let model = RepositoryModel()
        model.delegate = viewController
        viewController.model = model
        return viewController
    }
}

extension RepositoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? RepositoryTableViewCell else {
            fatalError()
        }
        let repository = repositories[indexPath.row]
        cell.prepare(model: repository)
        return cell
    }
}

extension RepositoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repository = repositories[indexPath.row]
        let pullRequestViewController = PullRequestViewController.create(repository: repository.name, owner: repository.ownerLogin)
        navigationController?.pushViewController(pullRequestViewController, animated: true)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if repositories.count - 1 == indexPath.row {
            self.fetch()
        }
    }

}

extension RepositoryViewController: RepositoryModelDelegate {
    func didUpdateRepositories() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.hideLoading()
        }

    }

    func didErrorRepositories() {
        print("Error!!")
        DispatchQueue.main.async { [weak self] in
            self?.hideLoading()
        }
    }
}
