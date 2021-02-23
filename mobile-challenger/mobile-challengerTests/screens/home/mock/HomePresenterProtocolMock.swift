//
//  HomePresenterProtocolMock.swift
//  mobile-challengerTests
//
//  Created by Leonardo Sugano on 21/02/21.
//

import UIKit
@testable import mobile_challenger

class HomePresenterProtocolMock: HomePresenterProtocol {
    //MARK: - Vars
    var calledLoader: Bool = false
    var calledEndLoader: Bool = false
    var calledSuccessData: Bool = false
    var calledErrorData: Bool = false
    var calledPerformOfSegue: Bool = false
    var segue: RepositoriesModel?
    var errorMessage: String = ""
    
    func showLoader() {
        self.calledLoader = true
    }
    
    func endLoader() {
        self.calledEndLoader = true
    }
    
    func showError(error: String) {
        self.calledErrorData = true
        self.errorMessage = error
    }
    
    func successData() {
        self.calledSuccessData = true
    }
    
    func performForSegueCall(repository: RepositoriesModel) {
        self.calledPerformOfSegue = true
        self.segue = repository
    }
    
    func reset() {
        self.calledLoader = false
        self.calledEndLoader = false
        self.calledSuccessData = false
        self.calledErrorData = false
        self.calledPerformOfSegue = false
        self.segue = nil
        self.errorMessage = ""
    }
}
