//
//  PresentersSpec.swift
//  SafraChallengeTests
//
//  Created by Ruan Gustavo de Oliveira on 17/03/21.
//

import Foundation
import Quick
import Nimble
@testable import SafraChallenge

class RepositoryPresenterMock: RepositoriesPresenter {
    var nextPageTest: Bool = false
    var didSelectCellTest: Bool = false
    
    override func nextPage() {
        super.nextPage()
        self.nextPageTest = true
    }
    
    override func didSelectCell(at index: Int) {
        super.didSelectCell(at: index)
        self.didSelectCellTest = true
    }
}

class PullRequestPresenterMock: PullRequestsPresenter {
    var viewDidLoadTest: Bool = false
    var viewWillAppearTest: Bool = false
    var didSelectCellTest: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewDidLoadTest = true
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        self.viewWillAppearTest = true
    }
    
    override func didSelectCell(at index: Int) {
        super.didSelectCell(at: index)
        self.didSelectCellTest = true
    }
}

class PresentersSpec: QuickSpec {
    override func spec() {
        describe("Testing App Presenters") {
            context("Repository") {
                var presenter: RepositoryPresenterMock!
                beforeEach {
                    let manager = GithubRepositoriesManager()
                    let interactor = GithubRepositoriesInteractor(manager: manager)
                    let router = RepositoryRouter()
                    presenter = RepositoryPresenterMock(interactor: interactor, router: router)
                }
                it("Presenter Init") {
                    expect(presenter).toNot(beNil())
                }
                
                context("Functions") {
                    it("Next Page") {
                        presenter.nextPage()
                        expect(presenter.nextPageTest).to(beTrue())
                    }
                    
                    it("Did Select Cell") {
                        waitUntil(timeout: DispatchTimeInterval.seconds(30)) { done in
                            presenter.didSelectCell(at: 0)
                            expect(presenter.didSelectCellTest).to(beTrue())
                            done()
                        }
                    }
                }
            }
            context("Pull Request") {
                var presenter: PullRequestPresenterMock!
                beforeEach {
                    let manager = GithubPullsRequestsManager()
                    let interactor = GithubPullRequestsInteractor(manager: manager)
                    let router = PullRequestRouter()
                    presenter = PullRequestPresenterMock(interactor: interactor, router: router)
                }
                it("Presenter Init") {
                    expect(presenter).toNot(beNil())
                }
                
                context("Functions") {
                    it("View Did Load") {
                        presenter.viewDidLoad()
                        expect(presenter.viewDidLoadTest).to(beTrue())
                    }
//                    
                    it("Count") {
                        let count = presenter.count
                        expect(count).to(equal(0))
                    }
                    it("Title") {
                        expect(presenter.title).to(equal("Github"))
                    }
                    it("Pull Request URL") {
                        expect(presenter.pullRequestURL).to(beNil())
                        var repository = RepositoryView()
                        repository.pullRequestsURL = "url"
                        presenter.repository = repository
                        expect(presenter.pullRequestURL).to(equal("url"))
                    }
                    it("View Will Appear") {
                        presenter.viewWillAppear()
                        expect(presenter.viewWillAppearTest).to(beTrue())
                    }
                    it("Did Select Cell") {
                        presenter.didSelectCell(at: 0)
                        expect(presenter.didSelectCellTest).to(beTrue())
                        
                        presenter.didSelectCellTest = false
                        var pr = PullRequestView()
                        pr.url = "https://www.google.com/"
                        presenter.viewModel = [pr]
                        presenter.didSelectCell(at: 0)
                        expect(presenter.didSelectCellTest).to(beTrue())
                    }
                    it("View Model") {
                        var pr = PullRequestView()
                        pr.state = "open"
                        var pr1 = PullRequestView()
                        pr1.state = "closed"
                        presenter.viewModel = [pr, pr1]
                        expect(presenter.viewModel).toNot(beNil())
                    }
                }
            }
        }
    }
}
