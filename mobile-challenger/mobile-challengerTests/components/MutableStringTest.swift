//
//  MutableStringTest.swift
//  mobile-challengerTests
//
//  Created by Leonardo Sugano on 21/02/21.
//

@testable import mobile_challenger
import Quick
import Nimble
import UIKit

class MutableStringTest: QuickSpec {
    
    override func spec() {
        describe("MutableString") {
            
            it("should return blue color") {
                let stringValue = "teste azul / teste verde"

                let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: stringValue)
                attributedString.setColorForText(textForAttribute: "teste azul", withColor: UIColor.yellowColor())
                attributedString.setColorForText(textForAttribute: "/ teste verde", withColor: UIColor.black)

                
                //TO DO
            }
        }
    }
}

