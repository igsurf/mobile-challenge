//
//  PullRequestViewController.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 14/03/21.
//

import UIKit

public class PullRequestViewController: UIViewController {
    
    var tableView: UITableView!
    var barViewCounter: BarCounterView!
    var rowHeight: CGFloat = 125
    var initPos: CGFloat {
        let y = self.navigationController?.navigationBar.frame.origin.y ?? 0
        let height = self.navigationController?.navigationBar.frame.size.height ?? 0
        return (y + height)
    }
    
    var presenter: PullRequestsPresenter?
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpNavigation()
        self.setUpBarView()
        self.setUpTableView()
        self.presenter?.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.viewWillAppear()
    }
    
    public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.tableView.updateSize(size: CGSize(width: size.width,
                                               height: size.height - (self.initPos + self.barViewCounter.frame.size.height)))
        self.tableView.reloadData()
        self.barViewCounter.frame.size.width = size.width
        self.barViewCounter.reloadData()
    }
}

extension PullRequestViewController {
    
    private func setUpTableView() {
        
        self.tableView = UITableView(frame: CGRect(x: 0,
                                                   y: self.barViewCounter.frame.origin.y + self.barViewCounter.frame.size.height,
                                                   width: self.view.frame.width,
                                                   height: self.view.frame.size.height - (self.initPos + self.barViewCounter.frame.size.height)),
                                     style: UITableView.Style.plain)
        
        PullRequestViewCell.registerCell(tableView: tableView)
        self.tableView.backgroundColor = UIColor.white
        self.tableView.assignTo(delegate: self, dataSource: self)
        self.tableView.setSeparator(style: .none, color: UIColor.clear)
        
        self.view.addSubview(self.tableView)
    }
    
    private func setUpNavigation() {
        self.presenter?.navigationItem = self.navigationItem
        self.title = self.presenter?.title
    }
    
    private func setUpBarView() {
        self.barViewCounter = BarCounterView(frame: CGRect(x: 0, y: initPos, width: self.view.frame.size.width, height: 30))
        self.view.addSubview(self.barViewCounter)
    }
}

extension PullRequestViewController: PullRequestsPresenterOutput {
    @objc func setPullRequests(opened: String, closed: String) {
        self.barViewCounter.setLeft(text: opened)
        self.barViewCounter.setRight(text: closed)
    }
    
    @objc func updateUIList() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.view.stopActivity()
        }
    }

    @objc func presentLoading() {
        self.view.presentActivity()
    }
}

extension PullRequestViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PullRequestViewCell.cellIdentifier, for: indexPath) as! PullRequestViewCell
        guard let pullRequest = self.presenter?.getPullRequest(at: indexPath.row) else { return cell }
        cell.setUp(pullrequest: pullRequest)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.presenter?.didSelectCell(at: indexPath.row)
    }
}
