//
//  ViewController.swift
//  GithubJavaPopV2
//
//  Created by Suh on 09/06/22.
//

import UIKit

class RepositoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var model = RepositoryModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        model.delegate = self
        model.fetchRepositories()
        
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
        let repository = model.repositories[indexPath.row]
        cell.prepare(model: repository)
        return cell
    }
    
}

extension RepositoryViewController {
    static func create() -> RepositoryViewController {
        let storyboard = UIStoryboard(name: "RepositoryStoryboard", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "RepositoryViewController") as? RepositoryViewController else {
            fatalError()
        }
        return viewController
    }
}

extension RepositoryViewController: RepositoryModelDelegate {
    func didUpdateRepositories() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
       
    }
}

