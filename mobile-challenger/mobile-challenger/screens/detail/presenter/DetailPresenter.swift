//
//  DetailPresenter.swift
//  mobile-challenger
//
//  Created by Leonardo Sugano on 19/02/21.
//

import Foundation

protocol DetailPresenterProtocol: class {
    func showLoader()
    func endLoader()
    func successData()
    func errorData(message: String)
    func openURL(url: String)
}

class DetailPresenter {
    
    //MARK: - Lets
    
    //MARK: - Vars
    weak var view: DetailPresenterProtocol?
    var manager = NetworkingManager()
    var repository: RepositoriesModel?
    var response : [PullRequestModel] = []
    var actualResponse : [PullRequestModel] = []
    var page: Int = 1
    var closed: Int = 0
    var opened: Int = 0
    
    //MARK: - Life cycle
    init(with view: DetailPresenterProtocol, repository: RepositoriesModel) {
        self.view = view
        self.repository = repository
    }
    
    //MARK: - Getters
    func getSizePullRequests() -> Int {
        return self.response.count
    }
    
    func getPullRequest(at index: IndexPath) -> PullRequestModel? {
        return response[index.row - 1]
    }
    
    func getStatePR() -> (Int, Int) {
        return (self.opened, self.closed)
    }

    //MARK: - Setter
    func setOpenAndClose() {
        for item in actualResponse {
            if let state = item.state, state.elementsEqual("open") {
                self.opened += 1
            } else {
                self.closed += 1
            }
        }
    }
    
    //MARK: - Aux Methods
    func incrementPage() {
        self.page += 1
    }
    
    func openUrl(at index: IndexPath) {
        if let url = self.response[index.row - 1].urlPR {
            self.view?.openURL(url: url)
        }
    }
    
    func refreshValues() {
        self.actualResponse = []
        self.page = 1
        self.closed = 0
        self.opened = 0
    }
    
    //MARK: - API
    func getPullrequest(refresh: Bool, pagination: Bool) {
        guard let repositoryName = repository?.fullName else {
            return
        }
        
        if refresh {
            self.refreshValues()
        }
        
        if !pagination && !refresh {
            self.view?.showLoader()
        }
        
        manager.getPullRequest(page: page, nameUrl: repositoryName) { [weak self] (response) in
            if let self = self {
                self.view?.endLoader()
                
                if refresh {
                    self.response = response
                } else {
                    self.response.append(contentsOf: response)
                }
                
                self.actualResponse = response
                self.setOpenAndClose()
                self.view?.successData()
            }
            
        } error: { [weak self] (errorMessage) in
            if let self = self {
                self.view?.endLoader()
                self.view?.errorData(message: errorMessage)
            }
        }
    }
}
