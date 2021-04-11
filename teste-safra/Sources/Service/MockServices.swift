//
//  MockServices.swift
//  teste-safra
//
//  Created by Gabriel Sousa on 11/04/21.
//

import Foundation

class MockServices: ServicesProtocol {
    func getRepositoriesList(language: CodeLanguage, page: Int, success: @escaping ([Repository]) -> Void, failure: @escaping (Error) -> Void) {
    }
}
