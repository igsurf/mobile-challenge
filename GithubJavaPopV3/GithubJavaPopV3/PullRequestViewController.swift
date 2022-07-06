//
//  PullRequestViewController.swift
//  GithubJavaPopV3
//
//  Created by Suh on 06/07/22.
//

import UIKit

class PullRequestViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var names: [String] = [
    "Carlos",
    "Julio",
    "Pedro",
    "Fernando",
    "Natan"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
}

extension PullRequestViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = names[indexPath.row]
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
