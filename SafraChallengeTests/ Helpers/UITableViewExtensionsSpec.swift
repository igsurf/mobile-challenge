//
//  UITableViewExtensionsSpec.swift
//  SafraChallengeTests
//
//  Created by Ruan Gustavo de Oliveira on 16/03/21.
//

import Foundation
import Quick
import Nimble
@testable import SafraChallenge

class TableViewMock:  UITableView {
    var separatorTest: Bool = false
    override func setSeparator(style: UITableViewCell.SeparatorStyle = .singleLine, color: UIColor = UIColor.lightGray) {
        super.setSeparator(style: style, color: color)
        self.separatorTest = true
    }
}

extension TableViewMock: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

class UITableViewExtensionsSpec: QuickSpec {
    override func spec() {
        describe("Test UITableView Extensions") {
            var tableView: TableViewMock!
            beforeEach {
                tableView = TableViewMock()
            }
            context("Function") {
                it("Assing To") {
                    tableView.assignTo(delegate: tableView, dataSource: tableView)
                    expect(tableView.delegate).to(beAKindOf(UITableViewDelegate.self))
                    expect(tableView.dataSource).to(beAKindOf(UITableViewDataSource.self))
                }
                
                it("Update Size") {
                    tableView.updateSize(size: CGSize(width: 100, height: 100))
                    expect(tableView.frame.size.width).to(equal(100))
                    expect(tableView.frame.size.height).to(equal(100))
                }
                
                it("Set Separator") {
                    tableView.setSeparator()
                    expect(tableView.separatorTest).to(beTrue())
                }
            }
        }
    }
}
