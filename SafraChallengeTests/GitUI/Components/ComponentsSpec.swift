//
//  ComponentsSpec.swift
//  SafraChallengeTests
//
//  Created by Ruan Gustavo de Oliveira on 17/03/21.
//

import Foundation
import Quick
import Nimble
@testable import SafraChallenge

class ComponentsSpec: QuickSpec {
    override func spec() {
        describe("Testing GitUI") {
            context("Components") {
                it("CounterView Fork") {
                    let cell = CounterView(type: .FORK)
                    cell.setup(count: 100)
                    expect(cell).toNot(beNil())
                    expect(cell.countLabel.text).to(equal("100"))
                }
                
                it("CounterView Star") {
                    let cell = CounterView(type: .STAR)
                    cell.setup(count: 1000)
                    expect(cell).toNot(beNil())
                    expect(cell.countLabel.text).to(equal("1000"))
                }
                
                it("CounterView Inits") {
                    let cell1 = CounterView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), type: .STAR)
                    expect(cell1).toNot(beNil())
                    
                    let cell2 = CounterView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
                    expect(cell2).toNot(beNil())
                }
                
                it("User View") {
                    let login = "Toperson"
                    let type = "Admin"
                    let cell = UserView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), orientation: .BOTTOM)
                    cell.setup(user: UserViewModel(login: login, type: type, avatar: ""))
                    expect(cell).toNot(beNil())
                    expect(cell.loginLabel.text).to(equal(login))
                    expect(cell.typeLabel.text).to(equal(type))
                    expect(cell.orientation).to(equal(.BOTTOM))
                }
                
                it("Bar Counter View") {
                    let left = "123 ab"
                    let right = "029 cd"
                    let cell = BarCounterView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
                    cell.setLeft(text: left)
                    cell.setRight(text: right)
                    expect(cell).toNot(beNil())
                    expect(cell.leftLabel.text).to(equal(left))
                    expect(cell.rightLabel.text).to(equal(right))
                }
            }
        }
    }
}
