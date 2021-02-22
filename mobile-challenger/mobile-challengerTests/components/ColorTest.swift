//
//  ColorTest.swift
//  mobile-challengerTests
//
//  Created by Leonardo Sugano on 21/02/21.
//

@testable import mobile_challenger
import Quick
import Nimble
import UIKit

class ColorTest: QuickSpec {
    
    override func spec() {
        describe("Color") {
            
            it("should return blue color") {
                expect(UIColor.blueColor()).to(equal(UIColor(red: CGFloat(84/255.0), green: CGFloat(129/255.0), blue: CGFloat(174/255.0), alpha: CGFloat(1.0))))
            }
            
            it("should return yellow color") {
                expect(UIColor.yellowColor()).to(equal(UIColor(red: CGFloat(213/255.0), green: CGFloat(150/255.0), blue: CGFloat(52/255.0), alpha: CGFloat(1.0))))
            }
            
            it("should return darkGray color") {
                expect(UIColor.darkGrayColor()).to(equal(UIColor(red: CGFloat(52/255.0), green: CGFloat(52/255.0), blue: CGFloat(56/255.0), alpha: CGFloat(1.0))))
            }
            
            it("should return lightGray color") {
                expect(UIColor.lightGrayColor()).to(equal(UIColor( red: CGFloat(170/255.0), green: CGFloat(170/255.0), blue: CGFloat(170/255.0), alpha: CGFloat(1.0))))
            }
        }
    }
}
