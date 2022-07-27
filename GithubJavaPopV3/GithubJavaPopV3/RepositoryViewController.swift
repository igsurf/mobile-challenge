//
//  ViewController.swift
//  GithubJavaPopV3
//
//  Created by Suh on 04/07/22.
//

import UIKit

class RepositoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewLoading: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var model: RepositoryModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        tableView.dataSource = self
        tableView.delegate = self
        //model?.delegate = self
        model?.fetchRepositories()
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
        return model?.repositories.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? RepositoryTableViewCell else {
            fatalError()
        }
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "")
        //cell.textLabel?.text = names[indexPath.row]
        guard let repository = model?.repositories[indexPath.row] else {
            return UITableViewCell(style: .default, reuseIdentifier: nil)
        }
        cell.prepare(model: repository)
        return cell
    }
}

extension RepositoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let repository = model?.repositories[indexPath.row] else { return }
        let pullRequestViewController = PullRequestViewController.create(repository: repository.name, owner: repository.ownerLogin)
        navigationController?.pushViewController(pullRequestViewController, animated: true)
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
