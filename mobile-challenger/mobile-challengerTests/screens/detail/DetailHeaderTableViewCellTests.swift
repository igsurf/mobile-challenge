//
//  DetailHeaderTableViewCellTests.swift
//  mobile-challengerTests
//
//  Created by Leonardo Sugano on 21/02/21.
//

@testable import mobile_challenger
import Quick
import Nimble

private let storyboardName = "home"
private let controllerID = "DetailViewController"
private let cellIdentifier = "DetailHeaderTableViewCell"

class DetailHeaderTableViewCellTests: QuickSpec {
    
    override func spec() {
        describe("DetailHeaderTableViewCell") {
            
            weak var viewController: DetailViewController!
            let repository = ModelsMock.setGetRepositoriesMockResponse().first
            let protocolMock = DetailPresenterProtocolMock()
            var detail: DetailPresenterMock!
            var cell = DetailHeaderTableViewCell()
            
            beforeEach {
                let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
                viewController = storyboard.instantiateViewController(identifier: controllerID) as? DetailViewController
                viewController.beginAppearanceTransition(true, animated: true)
                viewController.endAppearanceTransition()
                
                if let repo = repository {
                    detail = DetailPresenterMock(with: protocolMock, repository: repo)
                    detail.setDetailManagerMock()
                }
                
                viewController.presenter = detail
                viewController.viewDidLoad()
                
                let index = IndexPath(row: 0, section: 0)

                if let tableView = viewController.tableView, let cellTable = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: index) as?  DetailHeaderTableViewCell {
                    cell = cellTable
                }
            }
                
            it("should cell not be nil") {
                expect(cell).toNot(beNil())
            }
            
            it("should setup texts to cell") {
                let stringValue = "2 opened / 1 closed"

                let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: stringValue)
                attributedString.setColorForText(textForAttribute: "2 opened", withColor: UIColor.yellowColor())
                attributedString.setColorForText(textForAttribute: "/ 1 closed", withColor: UIColor.black)
                
                cell.setupCellWithPR(open: 2, close: 1)
                expect(cell.titleLabel?.attributedText).to(equal(attributedString))
                expect(cell.titleLabel?.font).to(equal(UIFont.boldSystemFont(ofSize: 14)))
            }
            
            
        }
    }
}

