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
}

class HomePresenter {
    weak var view: HomePresenterProtocol?
    
    init(with view: HomePresenterProtocol) {
        self.view = view
    }
    
    
}

