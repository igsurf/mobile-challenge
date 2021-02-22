//
//  LoaderTest.swift
//  mobile-challengerTests
//
//  Created by Leonardo Sugano on 21/02/21.
//

@testable import mobile_challenger
import Quick
import Nimble
import UIKit

class LoaderTest: QuickSpec {
    
    override func spec() {
        describe("Loader") {
            let view = UIView()
            
            it("should return loader at view") {
                view.showLoader()
                expect(view.subviews.last).to(beAKindOf(Loader.self))
            }
            
            it("should remove loader at view") {
                view.showLoader()
                view.removeLoader()
                expect(view.subviews.last).toEventually(beNil(), timeout: 3)
            }
            
            it("should be nil init with nscoder") {
                let loader = Loader(coder: NSCoder())
                expect(loader).to(beNil())
            }
            
            afterEach {
                view.removeLoader()
            }
            
        }
    }
    
}
