//
//  PullRequestViewController.swift
//  GithubJavaPopV3
//
//  Created by Suh on 06/07/22.
//

import UIKit
import SafariServices

class PullRequestViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var names: [String] = [
    "Carlos",
    "Julio",
    "Pedro",
    "Fernando",
    "Natan"
    ]
    
    var model = PullRequestModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        model.fetchPullRequest()
    }
    
}

extension PullRequestViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.pulls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PullRequestTableViewCell else {
            fatalError()
        }
//        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
//        cell.textLabel?.text = names[indexPath.row]
        let pulls = model.pulls[indexPath.row]
        cell.prepare(model: pulls)
        return cell
    }
    
}

extension PullRequestViewController {
    static func create() -> PullRequestViewController {
        let storyboard = UIStoryboard.init(name: "PullRequestStoryboard", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "PullRequestViewController") as? PullRequestViewController else {
            fatalError()
        }
        return vc
    }
}

extension PullRequestViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let URL = URL(string: model.pulls[indexPath.row].htmlUrl) else {
            return
        }
        let pullRequestViewController = SFSafariViewController(url: URL)
               navigationController?.pushViewController(pullRequestViewController, animated: true)
               print(model.pulls[indexPath.row].htmlUrl)
    }
}
