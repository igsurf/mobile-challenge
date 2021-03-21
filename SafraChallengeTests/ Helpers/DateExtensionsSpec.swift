//
//  DateExtensionsSpec.swift
//  SafraChallengeTests
//
//  Created by Ruan Gustavo de Oliveira on 16/03/21.
//

import Foundation
import Quick
import Nimble
@testable import SafraChallenge
 
class DateExtensionsSpec: QuickSpec {
    
    override func spec() {
        describe("Test Date Extensions") {
            context("Date") {
                it("To String Success") {
                    let strDate = Date().toString()
                    expect(strDate).toNot(beNil())
                    expect(strDate).to(beAKindOf(String.self))
                    expect(strDate).toNot(beEmpty())
                }
            }
        }
    }
}
