//
//  ViewController.swift
//  GithubJavaPopV3
//
//  Created by Suh on 04/07/22.
//

import UIKit

class RepositoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
