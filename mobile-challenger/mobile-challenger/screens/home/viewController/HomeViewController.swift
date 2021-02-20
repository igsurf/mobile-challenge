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
    private let cellIdentifier = "homeTableViewCell"
    private let segueIdentifier = "DetailSegue"
    
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
        
        let menuBtn = UIButton(type: .custom)
        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        menuBtn.setImage(UIImage(named:"img-menu"), for: .normal)
        
        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24)
        let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24)
        currWidth?.isActive = true
        currHeight?.isActive = true
        self.navigationItem.leftBarButtonItem = menuBarItem
    }
    
    private func setupTableView() {
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.tableFooterView = UIView()

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
    
    
    //MARK: - Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            if let viewController = segue.destination as? DetailViewController {
                
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        presenter.didSelectTableViewSegue(at: indexPath)
        
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        cell.setupColors()
        return cell
    }
    
    
}

extension HomeViewController: HomePresenterProtocol {
    func performForSegueCall() {
        performSegue(withIdentifier: segueIdentifier, sender: nil)

    }
    
    func successData() {
        
    }
    
    func errorData() {
        
    }
    
    
}
