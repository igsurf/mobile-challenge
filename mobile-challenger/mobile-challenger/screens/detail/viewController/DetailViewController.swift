//
//  DetailViewController.swift
//  mobile-challenger
//
//  Created by Leonardo Sugano on 19/02/21.
//

import UIKit

class DetailViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var headerView: UIView?
    @IBOutlet weak var headerLabel: UILabel?
    
    //MARK: - Lets
    private let cellIdentifier = "DetailTableViewCell"
    private let refreshControl = UIRefreshControl()

    //MARK: - Vars
    lazy var presenter = DetailPresenter(with: self)

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    //MARK: - Setup
    private func setup() {
        setupTableView()
    }
    
    private func setupTableView() {
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.tableFooterView = UIView()
        
        refreshControl.addTarget(self, action: #selector(getPullRequests), for: .valueChanged)

        
        if #available(iOS 10.0, *) {
            self.tableView?.refreshControl = self.refreshControl
        } else {
            self.tableView?.addSubview(self.refreshControl)
        }
    }
    
    //MARK: - Private methods
    //MARK: - API
    @objc private func getPullRequests() {
        self.refreshControl.endRefreshing()
    }
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.openUrl(at: indexPath)
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DetailTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setupColors()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension DetailViewController: DetailPresenterProtocol {
    func successData() {
        
    }
    
    func errorData() {
        
    }
    
    func openURL(url: String) {
        if let url = URL(string: "https://www.google.com"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:])
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
}
