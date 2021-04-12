//
//  CodeLanguageCellViewModelTests.swift
//  teste-safraTests
//
//  Created by Gabriel Sousa on 12/04/21.
//

import XCTest
@testable import teste_safra

class CodeLanguageCellViewModelTests: XCTestCase {

    // MARK: - Private Properties

    private var swiftViewModel: CodeLanguageCellViewModel?
    private var kotlinViewModel: CodeLanguageCellViewModel?
    private var javaViewModel: CodeLanguageCellViewModel?

    override func setUp() {
        super.setUp()
        swiftViewModel = CodeLanguageCellViewModel(language: .swift)
        javaViewModel = CodeLanguageCellViewModel(language: .java)
        kotlinViewModel = CodeLanguageCellViewModel(language: .kotlin)
    }

    // MARK: - Tests

    func testButtonColorSwift() {
        let expected = #colorLiteral(red: 0.9333333333, green: 0.4470588235, blue: 0.1960784314, alpha: 1)
        XCTAssertEqual(expected, swiftViewModel?.buttonColor)
    }

    func testButtonColorJava() {
        let expected = #colorLiteral(red: 0.04705882353, green: 0.3764705882, blue: 0.5137254902, alpha: 1)
        XCTAssertEqual(expected, javaViewModel?.buttonColor)
    }

    func testButtonColorKotlin() {
        let expected = #colorLiteral(red: 0.4, green: 0.6862745098, blue: 0.1568627451, alpha: 1)
        XCTAssertEqual(expected, kotlinViewModel?.buttonColor)
    }
}
