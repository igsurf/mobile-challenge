//
//  HomeTableViewCellTests.swift
//  mobile-challengerTests
//
//  Created by Leonardo Sugano on 21/02/21.
//

import XCTest

@testable import mobile_challenger
import Quick
import Nimble

private let storyboardName = "home"
private let controllerID = "HomeViewController"
private let cellIdentifier = "homeTableViewCell"

class HomeTableViewCellTests: QuickSpec {
    
    override func spec() {
        describe("DetailHeaderTableViewCell") {
            
            weak var viewController: HomeViewController!
            let protocolMock = HomePresenterProtocolMock()
            var detail: HomePresenterMock!
            var cell = HomeTableViewCell()
            
            beforeEach {
                let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
                viewController = storyboard.instantiateViewController(identifier: controllerID) as? HomeViewController
                viewController.beginAppearanceTransition(true, animated: true)
                viewController.endAppearanceTransition()

                detail = HomePresenterMock(with: protocolMock)
                detail.setHomeManagerMock()
                                
                viewController.presenter = detail
                viewController.viewDidLoad()
                
                let index = IndexPath(row: 0, section: 0)

                if let tableView = viewController.tableView, let cellTable = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: index) as?  HomeTableViewCell {
                    cell = cellTable
                }
            }
                
            it("should cell not be nil") {
                expect(cell).toNot(beNil())
            }
            
            it("should setup collors to cell") {
                cell.setupColors()
                expect(cell.forkImageView?.tintColor).to(equal(UIColor.yellowColor()))
                expect(cell.forkLabel?.textColor).to(equal(UIColor.yellowColor()))
                expect(cell.starsLabel?.textColor).to(equal(UIColor.yellowColor()))
                expect(cell.starImageView?.tintColor).to(equal(UIColor.yellowColor()))
                expect(cell.titleRepository?.textColor).to(equal(UIColor.blueColor()))
                expect(cell.userNameLabel?.textColor).to(equal(UIColor.blueColor()))
                expect(cell.descriptionRepositoryLabel?.textColor).to(equal(UIColor.black))
            }
            
            it("should setup text to cell") {
                let repo = ModelsMock.setGetRepositoriesMockResponse().first
                repo?.ownerImage = ""
                
                if let response = repo {
                    cell.setupCellWithRepositoriesDatas(response: response)
                    expect(cell.forkLabel?.text).to(equal("\(response.forksCount?.intValue ?? 0)"))
                    expect(cell.starsLabel?.text).to(equal("\(response.starsCount?.intValue ?? 0)"))
                    expect(cell.descriptionRepositoryLabel?.text).to(equal(response.descriptionRepository))
                    expect(cell.titleRepository?.text).to(equal(response.repositoryName))
                    expect(cell.userNameLabel?.text).to(equal(response.ownerUsername))
                    expect(cell.perfilImagemView?.image).to(equal(UIImage(named: "img-perfil-placeholder")))
                }
            }
            
            it("should setup text cell with default") {
                let repo = ModelsMock.setGetRepositoriesMockResponse().first
                repo?.ownerImage = nil
                repo?.forksCount = nil
                repo?.starsCount = nil
                if let response = repo {
                    cell.setupCellWithRepositoriesDatas(response: response)
                    expect(cell.forkLabel?.text).to(equal("0"))
                    expect(cell.starsLabel?.text).to(equal("0"))
                    expect(cell.perfilImagemView?.image).to(equal(UIImage(named: "img-perfil-placeholder")))
                }
             
            }
        }
    }
}
