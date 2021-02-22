//
//  DetailTests.swift
//  mobile-challengerTests
//
//  Created by Leonardo Sugano on 21/02/21.
//

@testable import mobile_challenger
import Quick
import Nimble

private let storyboardName = "home"
private let controllerID = "DetailViewController"

class DetailViewControllerTests: QuickSpec {
    
    override func spec() {
        describe("DetailViewController") {
            
            weak var viewController: DetailViewController!
            let repository = ModelsMock.setGetRepositoriesMockResponse().first
            let protocolMock = DetailPresenterProtocolMock()
            var detailPresenter: DetailPresenterMock!
            
            beforeEach {
                let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
                if #available(iOS 13.0, *) {
                    viewController = storyboard.instantiateViewController(identifier: controllerID) as? DetailViewController
                } else {
                    viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? DetailViewController
                }
                viewController.beginAppearanceTransition(true, animated: true)
                viewController.endAppearanceTransition()
                
                if let repo = repository {
                    detailPresenter = DetailPresenterMock(with: protocolMock, repository: repo)
                    detailPresenter.setDetailManagerMock()
                }
                
                viewController.presenter = detailPresenter
                viewController.viewDidLoad()
            }
            
            afterEach {
                viewController.endLoader()
                viewController = nil
            }
            
            it("should test get pull request") {
                viewController.getPullRequests()
                expect(viewController.presenter?.response).to(equal(ModelsMock.setPullRequestMockResponse()))
            }
            
            it("should test didSelect a row at index") {
                let indexPath = IndexPath(row: 2, section: 0)
                let tableView = UITableView()
                
                viewController.tableView(tableView, didSelectRowAt: indexPath)
                expect(detailPresenter.calledOpenUrl).to(equal(true))
                expect(detailPresenter.calledOpenUrlIndex).to(equal(indexPath))
            }
            
            it("should test endLoader protocol") {
                viewController.view.showLoader()
                viewController.refreshControl.beginRefreshing()
                viewController.tableView?.beginInfiniteScroll(true)
                
                viewController.endLoader()
                
                expect(viewController.view.subviews.last).toNot(beAKindOf(Loader.self))
                expect(viewController.refreshControl.isRefreshing).to(beFalse())
                expect(viewController.view.subviews.last).toNot(beAKindOf(Loader.self))
            }
            
            it("should test showLoader") {
                viewController.showLoader()
                expect(viewController.view.subviews.last).to(beAKindOf(Loader.self))
            }
            
            it("should test successData") {
                viewController.presenter?.getPullrequest(refresh: false, pagination: true)
                viewController.successData()
                if let tableView = viewController.tableView {
                    expect(viewController.tableView(tableView, numberOfRowsInSection: 0)).to(equal(4))
                }
            }
            
            it("should test errorData") {
                viewController.errorData(message: "teste de erro")
                let lastView = viewController.presentedViewController
                
                if let alert = lastView as? UIAlertController {
                    expect(alert.message).to(equal("teste de erro"))
                }
            }
 
            it("should test heightFor row") {
                let indexPath = IndexPath(row: 0, section: 0)
                if let tableView = viewController.tableView {
                    expect(viewController.tableView(tableView, heightForRowAt: indexPath)).to(equal(UITableView.automaticDimension))
                }
            }
            
            it("should test cell for row") {
                let firstIndex = IndexPath(row: 0, section: 0)
                let secondIndex = IndexPath(row: 1, section: 0)
                
                if let tableView = viewController.tableView {
                    expect(viewController.tableView(tableView, cellForRowAt: firstIndex)).to(beAKindOf(DetailHeaderTableViewCell.self))
                    expect(viewController.tableView(tableView, cellForRowAt: secondIndex)).to(beAKindOf(DetailTableViewCell.self))
                }
            }
        }
    }
}

