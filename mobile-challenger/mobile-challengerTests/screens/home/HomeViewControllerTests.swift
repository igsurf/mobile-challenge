//
//  HomeViewControllerTests.swift
//  mobile-challengerTests
//
//  Created by Leonardo Sugano on 21/02/21.
//

@testable import mobile_challenger
import Quick
import Nimble

private let storyboardName = "home"
private let controllerID = "HomeViewController"

class HomeViewControllerTests: QuickSpec {
    override func spec() {
        describe("HomeViewController") {
            
            weak var viewController: HomeViewController!
            let protocolMock = HomePresenterProtocolMock()
            var homePresenter: HomePresenterMock!
            
            beforeEach {
                let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
                if #available(iOS 13.0, *) {
                    viewController = storyboard.instantiateViewController(identifier: controllerID) as? HomeViewController
                } else {
                    viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? HomeViewController
                }
                viewController.beginAppearanceTransition(true, animated: true)
                viewController.endAppearanceTransition()
                
                homePresenter = HomePresenterMock(with: protocolMock)
                homePresenter.setHomeManagerMock()
                viewController.presenter = homePresenter
                viewController.viewDidLoad()
            }
            
            afterEach {
                viewController = nil
            }
            
            it("should test get repositories request") {
                viewController.getRepositories()
                expect(viewController.presenter.response).to(equal(ModelsMock.setGetRepositoriesMockResponse()))
            }
            
            it("should test prepare for segue") {
                let segueViewController = DetailViewController()
                let repositorie = ModelsMock.setGetRepositoriesMockResponse().first
                
                let segue = UIStoryboardSegue(identifier: "DetailSegue", source: viewController, destination: segueViewController)
                viewController.prepare(for: segue, sender: repositorie)
                expect(segueViewController.presenter?.repository).to(equal(repositorie))
            }
            
            it("should test didSelect a row") {
                let indexPath = IndexPath(row: 1, section: 0)
                if let tableView = viewController.tableView {
                    viewController.tableView(tableView, didSelectRowAt: indexPath)
                    expect(homePresenter.didSelectIndexPath).to(equal(indexPath))
                }
            }
            
            it("should return automatic dimension in tableView") {
                let indexPath = IndexPath(row: 1, section: 0)
                
                if let tableView = viewController.tableView {
                    expect(viewController.tableView(tableView, heightForRowAt: indexPath)).to(equal(UITableView.automaticDimension))
                }
            }
            
            it("should return 1, for number of rows") {
                if let tableView = viewController.tableView {
                    expect(viewController.tableView(tableView, numberOfRowsInSection: 0)).to(equal(1))
                }
            }
            
            it("should test cell for row") {
                let firstIndex = IndexPath(row: 0, section: 0)
                
                if let tableView = viewController.tableView {
                    expect(viewController.tableView(tableView, cellForRowAt: firstIndex)).to(beAKindOf(HomeTableViewCell.self))
                }
            }
            
            it("should test showLoader") {
                viewController.showLoader()
                expect(viewController.view.subviews.last).to(beAKindOf(Loader.self))
            }
            
            it("should test successData") {
                viewController.presenter.getRositories(refresh: false, pagination: true)
                viewController.successData()
                if let tableView = viewController.tableView {
                    expect(viewController.tableView(tableView, numberOfRowsInSection: 0)).to(equal(2))
                }
            }
            
            it("should test errorData") {
                viewController.showError(error: "teste de erro")
                let lastView = viewController.presentedViewController
                
                if let alert = lastView as? UIAlertController {
                    expect(alert.message).to(equal("teste de erro"))
                }
            }
            
            it("should test end loader") {
                viewController.endLoader()
                expect(viewController.tableView?.isAnimatingInfiniteScroll).to(beFalse())
                expect(viewController.refreshControl.isRefreshing).to(beFalse())
                expect(viewController.view.subviews.last).toNot(beAKindOf(Loader.self))
            }
        }
    }
}
