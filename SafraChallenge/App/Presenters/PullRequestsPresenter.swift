//
//  PullRequestsPresenter.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 02/03/21.
//

import UIKit

protocol PullRequestsPresenterInput {
    var count: Int { get }
    var title: String { get }
    
    func viewDidLoad()
    func viewWillAppear()
    func didSelectCell(at index: Int)
    func getPullRequest(at index: Int) -> PullRequestView
}

protocol PullRequestsPresenterOutput: class {
    func updateUIList()
    func presentLoading()
    func setPullRequests(opened: String, closed: String)
}

class PullRequestsPresenter: PullRequestsPresenterInput {
    var output: PullRequestsPresenterOutput?
    var interactor: GithubPullRequestsInteractorInput
    var router: PullRequestRouter
    
    var navigationItem: UINavigationItem?
    
    var repository: RepositoryView?
    
    var pullRequestURL: String? {
        if let url = self.repository?.pullRequestsURL {
            return url
        }
        return nil
    }
    
    var count: Int {
        return viewModel.count
    }
    
    var title: String {
        return self.repository?.name ?? "Github"
    }

    var viewModel: [PullRequestView] = [] {
        didSet {
            output?.updateUIList()
            self.setPullRequests()
        }
    }
    
    init(interactor: GithubPullRequestsInteractorInput, router: PullRequestRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        self.fetch()
    }
    
    func didSelectCell(at index: Int) {
        let pullrequest = self.getPullRequest(at: index)
        
        if let url = URL(string: pullrequest.url) {
            UIApplication.shared.open(url)
        }
    }
    
    func getPullRequest(at index: Int) -> PullRequestView {
        if self.viewModel.count > 0 {
            return self.viewModel[index]
        }
        return PullRequestView()
    }
    
    func viewWillAppear() {
        // TODO
    }
    
    private func fetch() {
        output?.presentLoading()
        DispatchQueue(label: "Fetch PullRequests").async {
            if ReachabilityNotifier.instance.isNetworkAvailable {
                if let url = self.pullRequestURL {
                    self.interactor.fetch(url: url, repository: self.repository ?? RepositoryView())
                }
            } else {
                self.fetched(pullRequests: self.repository?.pullRequests ?? [])
            }
        }
    }
    
    private func setPullRequests() {
        var opened: Int = 0
        var closed: Int = 0
        
        self.viewModel.forEach({ item in
            if item.state == "open" {
                opened += 1
            }
            if item.state == "closed" {
                closed += 1
            }
        })
        
        self.output?.setPullRequests(opened: "\(opened) opened", closed: "\(closed) closed")
    }
}

extension PullRequestsPresenter: GithubPullRequestsInteractorOutput {
    func fetched(pullRequests: [PullRequestView]) {
        self.viewModel = pullRequests
    }
}
