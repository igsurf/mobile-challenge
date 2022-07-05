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

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
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
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cell = UITableViewCell(style: .default, reuseIdentifier: "")
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
}
