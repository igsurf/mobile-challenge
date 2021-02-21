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
    func errorData()
    func openURL(url: String)
}

class DetailPresenter {
    
    //MARK: - Lets
    let manager = NetworkingManager()
    
    //MARK: - Vars
    weak var view: DetailPresenterProtocol?
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
            if item.state?.elementsEqual("open") ?? false {
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
        let url = self.response[index.row - 1].urlPR
        self.view?.openURL(url: url ?? String())
    }
    
    func refreshValues() {
        self.actualResponse = []
        self.page = 1
        self.closed = 0
        self.opened = 0
    }
    
    //MARK: - API
    func getPullrequest(refresh: Bool, pagination: Bool) {
        if refresh {
            self.refreshValues()
        }
        
        if !pagination && !refresh {
            self.view?.showLoader()
        }
        
        manager.getPullRequest(page: page, nameUrl: repository?.fullName ?? "") { [weak self] (response) in
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
        }
    }
}}
