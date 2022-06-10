//
//  ViewController.swift
//  GithubJavaPopV2
//
//  Created by Suh on 09/06/22.
//

import UIKit

class RepositoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var repositories: [Repository] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //title = "repositories"
        repositories = mockRepository()
        tableView.dataSource = self
        
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
        let repositories = repositories[indexPath.row]
        cell.prepare(model: repositories)
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

private func mockRepository() -> [Repository] {
    return [ .fixture(),
            .fixture(),
            .fixture(),
            .fixture(),
             .fixture(),
             .fixture(),
             .fixture(),
             .fixture(name: "joao", description: "kskjfhsi7tsegkfsge77trgao", stargazersCount: 23, forks: 23, owner: .fixture())
    ]
}
