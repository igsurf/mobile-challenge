//
//  HomePresenterMock.swift
//  mobile-challengerTests
//
//  Created by Leonardo Sugano on 21/02/21.
//

import UIKit
@testable import mobile_challenger

class HomePresenterMock: HomePresenter {
    
    //MARK: - Vars
    var calledOpenUrl: Bool = false
    var calledOpenUrlIndex: IndexPath = IndexPath(row: 0, section: 0)
    var didSelectIndexPath: IndexPath?
    
    //MARK: - Init
    override init(with view: HomePresenterProtocol) {
        super.init(with: view)
    }
    
    override func didSelectTableViewSegue(at index: IndexPath) {
        self.didSelectIndexPath = index
    }
    
    //MARK: - Mocks
    func setHomeManagerMock() {
        self.manager = NetworkingManagerMock()
    }
}
