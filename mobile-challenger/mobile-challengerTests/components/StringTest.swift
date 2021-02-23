//
//  StringTest.swift
//  mobile-challengerTests
//
//  Created by Leonardo Sugano on 21/02/21.
//

@testable import mobile_challenger
import Quick
import Nimble
import UIKit

class StringTest: QuickSpec {
    
    override func spec() {
        describe("String") {
            let dateFormat = "dd/MM/yyyy HH:mm:ss"
            
            it("should return localized string") {
                expect("home_title".localized()).to(equal("Github JavaPop"))
            }
            
            it("should formatter date") {
                expect("2021-02-20T05:48:54Z".transformDateToFormat(format: dateFormat)).to(equal("20/02/2021 02:48:54"))
            }
            
            it("should return empty formatter date") {
                expect("2021-02-20T05:48:54".transformDateToFormat(format: dateFormat)).to(equal(String()))

            }
            
        }
    }
    
}
