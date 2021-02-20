//
//  HomePresenter.swift
//  mobile-challenger
//
//  Created by Leonardo Sugano on 19/02/21.
//

import Foundation

protocol HomePresenterProtocol: class {
    func showLoader(refresh: Bool)
    func endLoader()
    func showError(error: String)
    func successData()
    func errorData()
    func performForSegueCall() //passar o objeto
}

class HomePresenter {
    
    //MARK: - Lets
    let manager = NetworkingManager()
    
    //MARK: - Vars
    weak var view: HomePresenterProtocol?
    var response : [RepositoriesModel] = []
    var page: Int = 0
    
    //MARK: - Life cycle
    init(with view: HomePresenterProtocol) {
        self.view = view
    }
    
    //MARK: - PerformForSegue
    func didSelectTableViewSegue(at index: IndexPath) {
        self.view?.performForSegueCall()
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
        self.response = []
        self.page = 0
    }
    
    //MARK: - Setters
    
    //MARK: - API
    func getRositories(refresh: Bool) {
        if refresh {
            self.refreshValues()
        }
        
        manager.getRepositories(page: page) { [weak self] (response) in
            if let self = self {
                self.view?.endLoader()
                self.response.append(contentsOf: response)
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

