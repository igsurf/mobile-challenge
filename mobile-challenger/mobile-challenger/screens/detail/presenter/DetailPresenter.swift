//
//  DetailPresenter.swift
//  mobile-challenger
//
//  Created by Leonardo Sugano on 19/02/21.
//

import Foundation

protocol DetailPresenterProtocol: class {
    func successData()
    func errorData()
    func openURL(url: String)
}

class DetailPresenter {
    weak var view: DetailPresenterProtocol?
    
    init(with view: DetailPresenterProtocol) {
        self.view = view
    }
    
    func openUrl(at index: IndexPath) {
        self.view?.openURL(url: "")
    }
}
