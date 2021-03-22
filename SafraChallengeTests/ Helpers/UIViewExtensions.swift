//
//  UIViewExtensions.swift
//  SafraChallengeTests
//
//  Created by Ruan Gustavo de Oliveira on 16/03/21.
//

import Foundation
import Quick
import Nimble
@testable import SafraChallenge
 
class UIViewMock: UIView {
    var presentActiveTest: Bool = false
    var stopActivityTest: Bool = false
    var positionTest: Bool = false
    var sizeTest: Bool = false
    var cornerRadiusTest: Bool = false
    var setBorderTest: Bool = false
    var circleTest: Bool = false
    
    override func presentActivity() {
        super.presentActivity()
        self.presentActiveTest = true
    }
    
    override func stopActivity() {
        super.stopActivity()
        self.stopActivityTest = true
    }
    
    override func position(_ position: CGPoint) {
        super.position(position)
        self.positionTest = true
    }
    
    override func size(_ size: CGSize) {
        super.size(size)
        self.sizeTest = true
    }
    
    override func cornerRadius(radius: CGFloat) {
        super.cornerRadius(radius: radius)
        self.cornerRadiusTest = true
    }
    
    override func setBorder(width: CGFloat, color: UIColor) {
        super.setBorder(width: width, color: color)
        self.setBorderTest = true
    }
    
    override func circle() {
        super.circle()
        self.circleTest = true
    }
}

class UIViewExtensions: QuickSpec {
    
    override func spec() {
        describe("Test UIView Extensions") {
            var view: UIViewMock!
            beforeEach {
                view = UIViewMock()
            }
            context("Function") {
                it("Present Activity") {
                    view.presentActivity()
                    expect(view.presentActiveTest).to(beTrue())
                }
                
                it("Stop Activity") {
                    view.stopActivity()
                    expect(view.stopActivityTest).to(beTrue())
                }
                
                it("Position") {
                    view.position(CGPoint(x: 0, y: 0))
                    expect(view.positionTest).to(beTrue())
                }
                
                it("Size") {
                    view.size(CGSize(width: 10, height: 10))
                    expect(view.sizeTest).to(beTrue())
                }
                
                it("Corner Radius") {
                    view.cornerRadius(radius: 5)
                    expect(view.cornerRadiusTest).to(beTrue())
                }
                
                it("Set Border") {
                    view.setBorder(width: 1, color: UIColor.titleLabel)
                    expect(view.setBorderTest).to(beTrue())
                }
                
                it("Circle") {
                    view.circle()
                    expect(view.circleTest).to(beTrue())
                }
                
                it("Hidden") {
                    expect(view.isVisible(view)).to(beFalse())
                }
                
                it("Visible") {
                    if let window = UIApplication.shared.windows.first, let rootViewController = window.rootViewController,
                       let rootView = rootViewController.view {
                        let visibileView = rootView.subviews[1]
                        expect(rootView.isVisible(visibileView)).to(beTrue())
                    }
                }
            }
        }
    }
}
