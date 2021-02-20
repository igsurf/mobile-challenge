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
        self.presenter.getRositories(refresh: false)
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
        self.presenter.getRositories(refresh: true)
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
        self.presenter.didSelectTableViewSegue(at: indexPath)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.getSizeRepositories()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setupColors()
        cell.setupCellWithRepositoriesDatas(response: self.presenter.getRepositorie(at: indexPath))
        return cell
    }
    
    
}

extension HomeViewController: HomePresenterProtocol {
    func showLoader(refresh: Bool) {
        
    }
    
    func endLoader() {
        self.refreshControl.endRefreshing()
    }
    
    func showError(error: String) {
        
    }
    
    func successData() {
        self.tableView?.reloadData()
    }
    
    func performForSegueCall() {
        performSegue(withIdentifier: segueIdentifier, sender: nil)
    }
    
    func errorData() {
        
    }
    
    
}
