//
//  PullRequestViewController.swift
//  GithubJavaPopV2
//
//  Created by Suh on 14/06/22.
//

import UIKit

class PullRequestViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var model = PullRequestModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Passandooooooo")

        // Do any additional setup after loading the view.
    }
    
    
    
}

extension PullRequestViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.pullRequests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        return cell
    }
    
}


extension PullRequestViewController {
    static func create() -> PullRequestViewController {
        let storyboard = UIStoryboard(name: "PullRequestStoryboard", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "PullRequestViewController") as? PullRequestViewController else {
            fatalError()
        }
        return viewController
    }
}
