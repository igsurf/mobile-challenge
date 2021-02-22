//
//  DetailPresenterMock.swift
//  mobile-challengerTests
//
//  Created by Leonardo Sugano on 21/02/21.
//

import UIKit
@testable import mobile_challenger

class DetailPresenterMock: DetailPresenter {
    
    //MARK: - Vars
    var calledOpenUrl: Bool = false
    var calledOpenUrlIndex: IndexPath = IndexPath(row: 0, section: 0)
    
    //MARK: - Init
    override init(with view: DetailPresenterProtocol, repository: RepositoriesModel) {
        super.init(with: view, repository: repository)
    }
    
    override func openUrl(at index: IndexPath) {
        self.calledOpenUrl = true
        self.calledOpenUrlIndex = index
    }
    
    //MARK: - Mocks
    func setDetailManagerMock() {
        self.manager = NetworkingManagerMock()
    }
}
