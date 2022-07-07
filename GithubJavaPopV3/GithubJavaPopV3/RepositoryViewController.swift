//
//  ViewController.swift
//  GithubJavaPopV3
//
//  Created by Suh on 04/07/22.
//

import UIKit

class RepositoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var names: [String] = [
    	"Ana",
    	"Julia",
    	"Paula",
    	"Vania",
    	"Livia",
    	"CArla",
    	"Kelly",
    	"SUH"
    ]
    
    var model = RepositoryModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        model.delegate = self
        model.fetchRepositories()
    }


}

extension RepositoryViewController {
    static func create() -> RepositoryViewController {
        let storyboard = UIStoryboard.init(name: "RepositoryStoryboard", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "RepositoryViewController") as? RepositoryViewController else {
            fatalError()
        }
        return viewController
    }
}

extension RepositoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? RepositoryTableViewCell else {
            fatalError()
        }
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "")
        //cell.textLabel?.text = names[indexPath.row]
        let repository = model.repositories[indexPath.row]
        cell.prepare(model: repository)
        return cell
    }
}

extension RepositoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let repository = model.repositories[indexPath.row]
        let pullRequestViewController = PullRequestViewController.create()
        navigationController?.pushViewController(pullRequestViewController, animated: true)
    }
}

extension RepositoryViewController: RepositoryModelDelegate {
    func didUpdateRepositories() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
