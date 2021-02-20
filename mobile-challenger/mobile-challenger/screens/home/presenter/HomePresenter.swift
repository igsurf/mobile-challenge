//
//  HomePresenter.swift
//  mobile-challenger
//
//  Created by Leonardo Sugano on 19/02/21.
//

import Foundation

protocol HomePresenterProtocol: class {
    func successData()
    func errorData()
    func performForSegueCall() //passar o objeto
}

class HomePresenter {
    weak var view: HomePresenterProtocol?
    
    init(with view: HomePresenterProtocol) {
        self.view = view
    }
    
    //MARK: - PerformForSegue
    func didSelectTableViewSegue(at index: IndexPath) {
        
        self.view?.performForSegueCall()
    }
    
}

