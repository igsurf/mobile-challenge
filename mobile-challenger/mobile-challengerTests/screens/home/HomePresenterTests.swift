//
//  HomePresenterTests.swift
//  mobile-challengerTests
//
//  Created by Leonardo Sugano on 21/02/21.
//

@testable import mobile_challenger
import Quick
import Nimble

class HomePresenterTests: QuickSpec {
    
    override func spec() {
        describe("HomePresenter") {
            let protocolMock = HomePresenterProtocolMock()
            var home: HomePresenter!
            let repository = ModelsMock.setGetRepositoriesMockResponse().first
            let indexPath = IndexPath(row: 0, section: 0)

            beforeEach {
                home = HomePresenter(with: protocolMock)
                
                protocolMock.reset()
                home.manager = NetworkingManagerMock()
                home.getRositories(refresh: false, pagination: false)
            }
            
            it("should test didselect tableview") {
                home.didSelectTableViewSegue(at: indexPath)
                                
                expect(protocolMock.calledPerformOfSegue).to(beTrue())
                expect(protocolMock.segue).to(equal(repository))
            }
            
            it("should return first repository") {
                expect(home.getRepositorie(at: indexPath)).to(equal(repository))
            }
            
            it("should return repository size 1") {
                expect(home.getSizeRepositories()).to(equal(1))
            }
            
            it("should incrementPage") {
                home.page = 3
                home.incrementPage()
                
                expect(home.page).to(equal(4))
            }
            
            it("should refresh page") {
                home.page = 5
                home.refreshValues()
                
                expect(home.page).to(equal(1))
            }
            
            it("should call show loader") {
                home.getRositories(refresh: false, pagination: false)
                expect(protocolMock.calledLoader).to(beTrue())
            }
            
            it("should call end loader and response need to get size 1, cause its not pagination") {
                home.getRositories(refresh: true, pagination: false)
                
                expect(protocolMock.calledEndLoader).to(beTrue())
                expect(home.getSizeRepositories()).to(equal(1))
            }
            
            it("should call error") {
                home.getRositories(refresh: true, pagination: false)
                expect(protocolMock.calledErrorData).to(beTrue())
            }
            
            it("should increment array when pagination") {
                home.getRositories(refresh: false, pagination: true)
                expect(home.getSizeRepositories()).to(equal(2))
            }
        }
    }
}

