//
//  RepositoriesPresenter.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 02/03/21.
//

import Foundation
import UIKit

protocol RepositoriesListPresenterInput {
    var count: Int { get }
    var title: String { get }
    
    func viewDidLoad()
    func viewWillAppear()
    func didSelectCell(at index: Int)
    func getRepository(at index: Int) -> RepositoryView
    func nextPage()
}

protocol RepositoriesListPresenterOutput: class {
    func updateUIList()
    func presentLoading()
}

class RepositoriesPresenter: RepositoriesListPresenterInput {
    
    weak var output: RepositoriesListPresenterOutput?
    var interactor: GithubRepositoriesInteractorInput
    var router: RepositoryRouter
    
    var indexPage: Int = 1
    var indexPageMax: Int = 34
        
    var navigationItem: UINavigationItem?
    
    var count: Int {
        return viewModel.count
    }
    
    var title: String = "Github - JAVA"
    var backButtonTitle: String {
        return ""
    }
    
    var viewModel: [RepositoryView] = [] {
        didSet {
            output?.updateUIList()
        }
    }
    
    init(interactor: GithubRepositoriesInteractorInput, router: RepositoryRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        output?.presentLoading()
        loadData()
    }
    
    func nextPage() {
        if self.indexPage < self.indexPageMax {
            self.indexPage += 1
            self.loadData()
        }
    }
    
    private func loadData() {
        DispatchQueue(label: "Fetch Repositories").async {
            if ReachabilityNotifier.instance.isNetworkAvailable {
                self.interactor.fetch(language: "JAVA", page: self.indexPage)
            } else {
                self.fetched(repositories: DatabaseController.instance.getRepositories())
            }
        }
    }
    
    func viewWillAppear() {
        // TODO
    }
    
    func didSelectCell(at index: Int) {
        router.presentPullRequests(repository: self.getRepository(at: index))
    }
    
    func getRepository(at index: Int) -> RepositoryView {
        if self.viewModel.count > 0 {
            let repository = self.viewModel[index]
            self.title = repository.name
            return repository
        }
        return RepositoryView()
    }
}

extension RepositoriesPresenter: GithubRepositoriesInteractorOutput {
    
    func fetched(repositories: [RepositoryView]) {
        if self.viewModel.count <= 0 {
            self.viewModel = repositories
        } else {
            self.viewModel.append(contentsOf: repositories)
        }
    }
}
