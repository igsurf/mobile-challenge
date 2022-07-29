//
//  PullRequestViewController.swift
//  GithubJavaPopV3
//
//  Created by Suh on 06/07/22.
//

// swiftlint:disable line_length

import UIKit
import SafariServices

class PullRequestViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var indicatorLoading: UIActivityIndicatorView!

    var model: PullRequestModel?
    var pulls: [PullRequest] {
        return model?.pulls ?? []
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetch()
    }

    private func fetch() {
        showLoading()
        self.model?.fetchPullRequest()
    }

    private func showLoading() {
        indicatorLoading.startAnimating()
        loadingView.isHidden = false
    }

    private func hideLoad() {
        indicatorLoading.stopAnimating()
        loadingView.isHidden = true
    }

}

extension PullRequestViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pulls.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            as? PullRequestTableViewCell else {
            fatalError()
        }
        let pulls = pulls[indexPath.row]
        cell.prepare(model: pulls)
        return cell
    }

}

extension PullRequestViewController: PullRequestModelDelegate {
    func didUpdatePulls() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.hideLoad()
        }
    }

    func didErrorPulls() {
        DispatchQueue.main.async { [weak self] in
            self?.hideLoad()
            print("Error!! Erro de load Pulls")
        }
    }
}

extension PullRequestViewController {
    static func create(repository: String, owner: String) -> PullRequestViewController {
        let storyboard = UIStoryboard.init(name: "PullRequestStoryboard", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "PullRequestViewController") as? PullRequestViewController else {
            fatalError()
        }
        let model = PullRequestModel(repository: repository, owner: owner)
        viewController.model = model
        model.delegate = viewController
        return viewController
    }
}

extension PullRequestViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let URL = URL(string: pulls[indexPath.row].htmlUrl) else {
            return
        }
        let pullRequestViewController = SFSafariViewController(url: URL)
               navigationController?.pushViewController(pullRequestViewController, animated: true)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if pulls.count - 1 == indexPath.row {
            self.fetch()
        }
    }

}
