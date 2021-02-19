//
//  HomeViewController.swift
//  mobile-challenger
//
//  Created by Leonardo Sugano on 19/02/21.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView?
    
    //MARK: - Lets
    private let refreshControl = UIRefreshControl()

    //MARK: - Vars
    lazy var presenter = HomePresenter(with: self)
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        
    }
    
    //MARK: - Setup
    private func setup() {
        self.setupNavigation()
        self.setupTableView()
    }
    
    private func setupNavigation() {
        self.title = "home_title".localized()
    }
    
    private func setupTableView() {
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        refreshControl.addTarget(self, action: #selector(getRepository), for: .valueChanged)

        
        if #available(iOS 10.0, *) {
            self.tableView?.refreshControl = self.refreshControl
        } else {
            self.tableView?.addSubview(self.refreshControl)
        }
    }
    
    //MARK: - API
    @objc private func getRepository() {
        self.refreshControl.endRefreshing()
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "homeTableViewCell", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        cell.setupColors()
        return cell
    }
    
    
}

extension HomeViewController: HomePresenterProtocol {
    func successData() {
        
    }
    
    func errorData() {
        
    }
    
    
}
