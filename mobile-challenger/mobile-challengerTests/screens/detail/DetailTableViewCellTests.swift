//
//  DetailTableViewCellTests.swift
//  mobile-challengerTests
//
//  Created by Leonardo Sugano on 21/02/21.
//

@testable import mobile_challenger
import Quick
import Nimble

private let storyboardName = "home"
private let controllerID = "DetailViewController"
private let cellIdentifier = "DetailTableViewCell"

class DetailTableViewCellTests: QuickSpec {
    
    override func spec() {
        describe("DetailTableViewCell") {
            
            weak var viewController: DetailViewController!
            let repository = ModelsMock.setGetRepositoriesMockResponse().first
            let protocolMock = DetailPresenterProtocolMock()
            var detailPresenter: DetailPresenterMock!
            var cell = DetailTableViewCell()
            
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
                
                let index = IndexPath(row: 1, section: 0)

                if let tableView = viewController.tableView, let cellTable = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: index) as?  DetailTableViewCell {
                    cell = cellTable
                }
            }
                
            it("should cell not be nil") {
                expect(cell).toNot(beNil())
            }
            
            it("should setup collors to cell") {
                cell.setupColors()
                expect(cell.titlePullRequestLabel?.textColor).to(equal(UIColor.blueColor()))
                expect(cell.descriptionPullRequestLabel?.textColor).to(equal(UIColor.black))
                expect(cell.userNameLabel?.textColor).to(equal(UIColor.blueColor()))
                expect(cell.dateLabel?.textColor).to(equal(UIColor.lightGrayColor()))
            }
            
            it("should setup cell with pull request") {
                let pullRequest = ModelsMock.setPullRequestMockResponse().first
                pullRequest?.ownerImage = ""
                cell.setupCellWithPullRequest(request:pullRequest)
                expect(cell.titlePullRequestLabel?.text).to(equal(pullRequest?.titlePR))
                expect(cell.descriptionPullRequestLabel?.text).to(equal(pullRequest?.descriptionPR))
                expect(cell.userNameLabel?.text).to(equal(pullRequest?.ownerUsername))
                expect(cell.dateLabel?.text).to(equal(pullRequest?.createDate?.transformDateToFormat(format: "dd/MM/yyyy HH:mm:ss")))
                expect(cell.userImageView?.image).to(equal(UIImage(named: "img-perfil-placeholder")))
            }
            
            it("should setup image with placeholder") {
                let pullRequest = ModelsMock.setPullRequestMockResponse().first
                pullRequest?.ownerImage = nil

                cell.setupCellWithPullRequest(request:pullRequest)
                expect(cell.userImageView?.image).to(equal(UIImage(named: "img-perfil-placeholder")))
            }
        }
    }
}

