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
    
    //MARK: - Lets
    var cellIdentifier = "DetailTableViewCell"
    var headerCellIdentifier = "DetailHeaderTableViewCell"
    var refreshControl = UIRefreshControl()
    var headerHeight: CGFloat = 24
    var application = UIApplication.shared
    
    //MARK: - Vars
    var presenter: DetailPresenter?

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    //MARK: - Setup
    private func setup() {
        self.setupNavigationBar()
        self.setupTableView()
        self.presenter?.getPullrequest(refresh: false, pagination: false)
    }
    
    private func setupNavigationBar() {
        self.title = self.presenter?.repository?.repositoryName
    }
    
    private func setupTableView() {
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.tableFooterView = UIView()
        
        refreshControl.addTarget(self, action: #selector(getPullRequests), for: .valueChanged)

        self.tableView?.addInfiniteScroll(handler: { [weak self] (tableView) in
            if let self = self {
                self.presenter?.incrementPage()
                self.presenter?.getPullrequest(refresh: false, pagination: true)
            }
        })
        
        if #available(iOS 10.0, *) {
            self.tableView?.refreshControl = self.refreshControl
        } else {
            self.tableView?.addSubview(self.refreshControl)
        }
    }
    
    //MARK: - API
    @objc func getPullRequests() {
        self.presenter?.getPullrequest(refresh: true, pagination: true)
    }
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > 0 {
            tableView.deselectRow(at: indexPath, animated: true)
            self.presenter?.openUrl(at: indexPath)
        }
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.getSizePullRequests() ?? 0 + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == .zero {
            guard let headerCell = tableView.dequeueReusableCell(withIdentifier: headerCellIdentifier, for: indexPath) as? DetailHeaderTableViewCell else {
                return UITableViewCell()
            }
            
            let state = self.presenter?.getStatePR()
            
            if let open = state?.0, let close = state?.1 {
                headerCell.setupCellWithPR(open: open, close: close)
            }
            
            return headerCell
        }
                
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DetailTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setupCellWithPullRequest(request: self.presenter?.getPullRequest(at: indexPath))
        cell.setupColors()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension DetailViewController: DetailPresenterProtocol {
    func endLoader() {
        self.view.removeLoader()
        self.refreshControl.endRefreshing()
        self.tableView?.finishInfiniteScroll()
    }
    
    func showLoader() {
        self.view.showLoader()
    }
    
    func successData() {
        self.tableView?.reloadData()
    }
    
    func errorData(message: String) {
        let alert = UIAlertController(title: "error_title".localized(), message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok".localized(), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func openURL(url: String) {
        if let url = URL(string: url), application.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                application.open(url, options: [:])
            } else {
                application.openURL(url)
            }
        }
    }
    
}
