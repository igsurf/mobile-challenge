//
//  DetailPresenterProtocolMock.swift
//  mobile-challengerTests
//
//  Created by Leonardo Sugano on 21/02/21.
//

import UIKit
@testable import mobile_challenger

class DetailPresenterProtocolMock: DetailPresenterProtocol {
    
    //MARK: - Vars
    var calledLoader: Bool = false
    var calledEndLoader: Bool = false
    var calledSuccessData: Bool = false
    var calledErrorData: Bool = false
    var calledOpenUrl: Bool = false
    var openUrl: String = ""
    var errorMessage: String = ""
    
    func showLoader() {
        self.calledLoader = true
    }
    
    func endLoader() {
        self.calledEndLoader = true
    }
    
    func successData() {
        self.calledSuccessData = true
    }
    
    func errorData(message: String) {
        self.calledErrorData = true
        self.errorMessage = message
    }
    
    func openURL(url: String) {
        self.calledOpenUrl = true
        self.openUrl = url
    }
    
    func reset() {
        self.calledLoader = false
        self.calledEndLoader = false
        self.calledSuccessData = false
        self.calledErrorData = false
        self.calledOpenUrl = false
        self.openUrl = ""
        self.errorMessage = ""
    }
    
}
