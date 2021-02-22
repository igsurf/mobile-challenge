//
//  DetailPresenterTests.swift
//  mobile-challengerTests
//
//  Created by Leonardo Sugano on 21/02/21.
//

import XCTest

@testable import mobile_challenger
import Quick
import Nimble

class DetailPresenterTests: QuickSpec {
    
    override func spec() {
        describe("DetailPresenter") {
            let repository = ModelsMock.setGetRepositoriesMockResponse().first
            let protocolMock = DetailPresenterProtocolMock()
            var detailPresenter: DetailPresenter!
                        
            beforeEach {
                if let repo = repository {
                    detailPresenter = DetailPresenter(with: protocolMock, repository: repo)
                }
                
                protocolMock.reset()
                detailPresenter.manager = NetworkingManagerMock()
            }
            
            it("should refresh values") {
                detailPresenter.actualResponse = ModelsMock.setPullRequestMockResponse()
                detailPresenter.page = 4
                detailPresenter.closed = 2
                detailPresenter.opened = 5
                
                detailPresenter.refreshValues()
                expect(detailPresenter.page).to(equal(1))
                expect(detailPresenter.closed).to(equal(0))
                expect(detailPresenter.opened).to(equal(0))
                
                detailPresenter.getPullrequest(refresh: true, pagination: false)
                
                expect(detailPresenter.page).to(equal(1))
                expect(detailPresenter.closed).to(equal(1))
                expect(detailPresenter.opened).to(equal(1))
                expect(protocolMock.calledLoader).to(equal(false))
                expect(protocolMock.calledSuccessData).to(equal(true))
                expect(protocolMock.calledEndLoader).to(equal(true))
            }
            
            it("should return size of pull request") {
                detailPresenter.getPullrequest(refresh: true, pagination: false)
                expect(detailPresenter.getSizePullRequests()).to(equal(2))
            }
            
            it("should return pull request at index 0") {
                detailPresenter.getPullrequest(refresh: true, pagination: false)
                
                let indexPath = IndexPath(row: 1, section: 0)
                
                expect(detailPresenter.getPullRequest(at: indexPath)).to(equal(ModelsMock.setPullRequestMockResponse().first))
            }
            
            it("should return the opened and closed PR") {
                detailPresenter.getPullrequest(refresh: true, pagination: false)
                let state = detailPresenter.getStatePR() //open closed
                
                expect(state.0).to(equal(1))
                expect(state.1).to(equal(1))
            }
            
            it("should increment page") {
                detailPresenter.page = 3
                detailPresenter.incrementPage()
                
                expect(detailPresenter.page).to(equal(4))
            }
            
            it("should open url to first index") {
                let indexPath = IndexPath(row: 1, section: 0)
                
                detailPresenter.getPullrequest(refresh: true, pagination: false)
                
                detailPresenter.openUrl(at: indexPath)
                expect(protocolMock.calledOpenUrl).to(beTrue())
                expect(protocolMock.openUrl).to(equal("https://github.com/CyC2018/CS-Notes/pull/1052"))
            }
            
            it("should call showLoader") {
                detailPresenter.getPullrequest(refresh: false, pagination: false)
                expect(protocolMock.calledLoader).to(beTrue())
            }
            
            it("should append item when pagination") {
                detailPresenter.getPullrequest(refresh: false, pagination: false)
                detailPresenter.getPullrequest(refresh: false, pagination: true)
                
                expect(detailPresenter.getSizePullRequests()).to(equal(4))
            }
            
            it("should call error") {
                detailPresenter.getPullrequest(refresh: false, pagination: false)
                expect(protocolMock.calledErrorData).to(beTrue())
                expect(protocolMock.errorMessage).to(equal("error mocado"))
            }
            
            it("should get pull request when has repository name") {
                detailPresenter.getPullrequest(refresh: false, pagination: false)
                expect(protocolMock.calledSuccessData).to(beTrue())
            }
            
            it("should dont get pull request when hasnt repository name") {
                detailPresenter.repository = nil
                detailPresenter.getPullrequest(refresh: false, pagination: false)
                expect(protocolMock.calledSuccessData).to(beFalse())
            }
        }
    }
}

