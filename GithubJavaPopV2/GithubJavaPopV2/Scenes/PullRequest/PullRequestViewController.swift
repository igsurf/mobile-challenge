//
//  PullRequestViewController.swift
//  GithubJavaPopV2
//
//  Created by Suh on 14/06/22.
//

import UIKit

class PullRequestViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var model: PullRequestModel?
    var pullRequests: [PullRequest] {
        return model?.pullRequests ?? []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        model?.fetchPullRequests()
        
    }    
}

extension PullRequestViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pullRequests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PullRequestTableViewCell else {
            fatalError()
        }
        let pullRequest = pullRequests[indexPath.row]
        cell.prepare(model: pullRequest)
        return cell
    }
}

extension PullRequestViewController: PullRequestModalDelegate {
    func didupdatePullRequests() {
        tableView.reloadData()
    }
}

extension PullRequestViewController {
    static func create(owner: String, repository: String) -> PullRequestViewController {
        let storyboard = UIStoryboard(name: "PullRequestStoryboard", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "PullRequestViewController") as? PullRequestViewController else {
            fatalError()
        }
        
        let model = PullRequestModel(owner: owner, repository: repository)
        viewController.model = model
        model.delegate = viewController
        return viewController
    }
}

