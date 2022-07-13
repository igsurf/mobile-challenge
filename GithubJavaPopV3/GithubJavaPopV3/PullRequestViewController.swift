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
    
    var model: PullRequestModel?
    var pulls: [PullRequest] {
        return model?.pulls ?? []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        model?.fetchPullRequest()
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PullRequestTableViewCell else {
            fatalError()
        }
//        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
//        cell.textLabel?.text = names[indexPath.row]
        let pulls = pulls[indexPath.row]
        cell.prepare(model: pulls)
        return cell
    }
    
}

extension PullRequestViewController: PullRequestModelDelegate {
    func didUpdatePulls() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func didErrorPulls() {
        print("Error!!!")
    }
}

extension PullRequestViewController {
    static func create(repository: String, owner: String) -> PullRequestViewController {
        let storyboard = UIStoryboard.init(name: "PullRequestStoryboard", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "PullRequestViewController") as? PullRequestViewController else {
            fatalError()
        }
        let model = PullRequestModel(repository: repository, owner: owner)
        vc.model = model
        model.delegate = vc
        return vc
    }
}

extension PullRequestViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let URL = URL(string: pulls[indexPath.row].htmlUrl) else {
            return
        }
        let pullRequestViewController = SFSafariViewController(url: URL)
               navigationController?.pushViewController(pullRequestViewController, animated: true)
               print(pulls[indexPath.row].htmlUrl)
    }
}


