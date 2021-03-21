//
//  StringExtensionsSpec.swift
//  SafraChallengeTests
//
//  Created by Ruan Gustavo de Oliveira on 16/03/21.
//

import Foundation
import Quick
import Nimble
@testable import SafraChallenge
 
class StringExtensionsSpec: QuickSpec {
    
    override func spec() {
        describe("Test String Extensions") {
            context("String") {
                it("To Date Fail") {
                    let date = "".toDate()
                    expect(date).to(beNil())
                }
                it("To Date Success") {
                    let date = "2012-10-19T15:02:57Z".toDate()
                    expect(date).toNot(beNil())
                    expect(date).to(beAKindOf(Date.self))
                }
            }
        }
    }
}
