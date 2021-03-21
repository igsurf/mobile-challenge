//
//  ViewController.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 21/02/21.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView: UITableView!
    var rowHeight: CGFloat = 125
    var fetchingMore: Bool = false
    
    var presenter: RepositoriesPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpNavigation()
        self.setUpTableView()
        self.presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
        self.tableView.reloadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if self.tableView != nil {
            self.tableView.updateSize(size: size)
            self.tableView.reloadData()
        }
    }
}

extension ViewController {
    
    private func setUpTableView() {
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0,
                                                   width: self.view.frame.width,
                                                   height: self.view.frame.height - 20), style: UITableView.Style.plain)
        
        RepositoryViewCell.registerCell(tableView: tableView)
        self.tableView.backgroundColor = UIColor.white
        self.tableView.assignTo(delegate: self, dataSource: self)
        
        self.view.addSubview(self.tableView)
    }
    
    private func setUpNavigation() {
        self.presenter?.navigationItem = self.navigationItem
        self.title = self.presenter?.title
        self.navigationItem.backButtonTitle = self.presenter?.backButtonTitle
    }
}

extension ViewController: RepositoriesListPresenterOutput {
    func updateUIList() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.view.stopActivity()
            self.fetchingMore = true
        }
    }

    func presentLoading() {
        self.view.presentActivity()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryViewCell.cellIdentifier, for: indexPath) as! RepositoryViewCell
        let repository = self.presenter?.getRepository(at: indexPath.row) ?? RepositoryView()
        cell.setup(repository: repository)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter?.didSelectCell(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if self.fetchingMore && (offsetY >= (contentHeight - scrollView.frame.height)) {
            self.fetchingMore = false
            self.presenter?.nextPage()
        }
    }
}
