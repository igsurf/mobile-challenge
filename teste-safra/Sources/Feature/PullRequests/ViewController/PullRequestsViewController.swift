//
//  PullRequestsViewController.swift
//  teste-safra
//
//  Created by Gabriel Sousa on 12/04/21.
//

import UIKit

class PullRequestsViewController: BaseViewController {

    // MARK: - Storyboard Outlets

    @IBOutlet var pullRequestsTableView: UITableView!
    @IBOutlet var repositoriesCountLabel: UILabel!

    // MARK: - Constants

    private let kTableViewCellIdentifier = "PullRequestCell"

    // MARK: - Private Properties
    
    private var viewModel: PullRequestsViewModel?
    private var repositoryName: String?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableview()
        setupLabels()
        navigationItem.title = repositoryName
    }

    // MARK: - Public Methods

    func setupController(viewModel: PullRequestsViewModel, repositoryName: String) {
        self.viewModel = viewModel
        self.repositoryName = repositoryName
    }

    // MARK: - Private Methods

    private func setupLabels() {
        repositoriesCountLabel.attributedText = viewModel?.openClosedTitle
    }

    private func setupTableview() {
        let nib = UINib(nibName: kTableViewCellIdentifier, bundle: nil)
        pullRequestsTableView.register(nib, forCellReuseIdentifier: kTableViewCellIdentifier)
        pullRequestsTableView.delegate = self
        pullRequestsTableView.dataSource = self
    }
}

// MARK: - Tableview delegate

extension PullRequestsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.pullRequestsCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kTableViewCellIdentifier, for: indexPath) as? PullRequestCell, let pullRequest = viewModel?.getPullRequest(position: indexPath.row) else {
            return UITableViewCell()
        }
        let cellViewModel = PullRequestCellViewModel(model: pullRequest)
        cell.setup(viewModel: cellViewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = viewModel?.getPullRequestURL(position: indexPath.row) else { return }
        UIApplication.shared.openURL(url)
    }
}
