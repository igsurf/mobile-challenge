//
//  HomePresenter.swift
//  mobile-challenger
//
//  Created by Leonardo Sugano on 19/02/21.
//

import Foundation

protocol HomePresenterProtocol: class {
    func showLoader()
    func endLoader()
    func showError(error: String)
    func successData()
    func performForSegueCall(repository: RepositoriesModel)
}

class HomePresenter {
    
    //MARK: - Lets
    
    //MARK: - Vars
    var manager = NetworkingManager()
    weak var view: HomePresenterProtocol?
    var response : [RepositoriesModel] = []
    var page: Int = 1
    
    //MARK: - Life cycle
    init(with view: HomePresenterProtocol) {
        self.view = view
    }
    
    //MARK: - PerformForSegue
    func didSelectTableViewSegue(at index: IndexPath) {
        self.view?.performForSegueCall(repository: self.getRepositorie(at: index))
    }
    
    //MARK: - Getters
    func getRepositorie(at index: IndexPath) -> RepositoriesModel {
        return self.response[index.row]
    }
    
    func getSizeRepositories() -> Int {
        return self.response.count
    }
    
    func incrementPage() {
        self.page += 1
    }
    
    func refreshValues() {
        self.page = 1
    }
    
    //MARK: - Setters
    
    //MARK: - API
    func getRositories(refresh: Bool, pagination: Bool) {
        if refresh {
            self.refreshValues()
        }
        
        if !pagination && !refresh {
            self.view?.showLoader()
        }
        
        manager.getRepositories(page: page) { [weak self] (response) in
            if let self = self {
                self.view?.endLoader()

                if refresh {
                    self.response = response
                } else {
                    self.response.append(contentsOf: response)
                }
                
                self.view?.successData()
            }
        } error: { [weak self] (errorMessage) in
            if let self = self {
                self.view?.endLoader()
                self.view?.showError(error: errorMessage)
            }
        }
    }
}

