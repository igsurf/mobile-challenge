//
//  ViewControllersSpec.swift
//  SafraChallengeTests
//
//  Created by Ruan Gustavo de Oliveira on 17/03/21.
//

import Foundation
import Quick
import Nimble
@testable import SafraChallenge

protocol TestViewControllersDelegate {
    func completion(_ isTrue: Bool, testNext: Bool)
}


class RepositoriesViewControllerMock: ViewController {
    var viewDidLoadTest: Bool = false
    var viewWillTransitionTest: Bool = false
    var delegate: TestViewControllersDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewDidLoadTest = true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.viewWillTransitionTest = true
        if let delegate = self.delegate {
            delegate.completion(self.viewWillTransitionTest, testNext: true)
        }
    }
}

class PullRequestViewControllerMock: PullRequestViewController {
    var viewDidLoadTest: Bool = false
    var viewWillTransitionTest: Bool = false
    var setPullRequestsTest: Bool = false
    var updateUIListTest: Bool = false
    var presentLoadingTest: Bool = false
    var delegate: TestViewControllersDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewDidLoadTest = true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.viewWillTransitionTest = true
        if let delegate = self.delegate {
            delegate.completion(self.viewWillTransitionTest, testNext: false)
        }
    }
    
    override func setPullRequests(opened: String, closed: String) {
        super.setPullRequests(opened: opened, closed: closed)
        self.setPullRequestsTest = true
    }
    
    override func updateUIList() {
        super.updateUIList()
        self.updateUIListTest = true
    }
    
    override func presentLoading() {
        super.presentLoading()
        self.presentLoadingTest = true
    }
}

class ViewControllersSpec: QuickSpec {
    var done: (() -> Void)?
    var orientation: Int {
        if UIDevice.current.orientation.isPortrait {
            return UIInterfaceOrientation.landscapeLeft.rawValue
        } else {
            return UIInterfaceOrientation.portrait.rawValue
        }
    }
    override func spec() {
        describe("Testing View Controllers") {
            context("Repositories ViewController") {
                let viewController: RepositoriesViewControllerMock! = RepositoriesViewControllerMock()
                
                beforeEach {
                    viewController.viewDidLoad()
                }
                
                it ("View Did Load") {
                    expect(viewController.viewDidLoadTest).to(beTrue())
                }
                
                it ("View Will Transition") {
                    viewController.delegate = self
                    viewController.viewDidLoad()
                    if let window = UIApplication.shared.windows.first, let rootViewController = window.rootViewController {
                        waitUntil(timeout: DispatchTimeInterval.seconds(30)) { done in
                            self.done = done
                            rootViewController.present(viewController, animated: false, completion: {
                                UIDevice.current.setValue(self.orientation, forKey: "orientation")
                            })
                        }
                    }
                }
            }
            context("PullRequests ViewController") {
                let viewController: PullRequestViewControllerMock! = PullRequestViewControllerMock()

                beforeEach {
                    viewController.viewDidLoad()
                }
                
                it ("View Did Load") {
                    expect(viewController.viewDidLoadTest).to(beTrue())
                }
                
                it ("Set Pull Requests") {
                    viewController.setPullRequests(opened: "18", closed: "10")
                    expect(viewController.setPullRequestsTest).to(beTrue())
                }
                
                it ("Update UIList") {
                    viewController.updateUIList()
                    expect(viewController.updateUIListTest).to(beTrue())
                }
                
                it ("Present Loading") {
                    viewController.presentLoading()
                    expect(viewController.presentLoadingTest).to(beTrue())
                }
                
                it ("View Will Transition") {
                    viewController.delegate = self
                    viewController.viewDidLoad()
                    if let window = UIApplication.shared.windows.first, let rootViewController = window.rootViewController {
                        waitUntil(timeout: DispatchTimeInterval.seconds(60)) { done in
                            self.done = done
                            rootViewController.presentedViewController?.present(viewController, animated: false, completion: {
                                UIDevice.current.setValue(self.orientation, forKey: "orientation")
                            })
                        }
                    }
                }
            }
        }
    }
}

extension ViewControllersSpec: TestViewControllersDelegate {
    func completion(_ isTrue: Bool, testNext: Bool) {
        expect(isTrue).to(beTrue())
        if let done = self.done {
            done()
            self.done = nil
        }
    }
}
