//
//  MockServices.swift
//  teste-safra
//
//  Created by Gabriel Sousa on 11/04/21.
//

import UIKit

class MockServices: ServicesProtocol {
    func getUser(username: String, success: @escaping (Owner) -> Void, failure: @escaping (Error) -> Void) {
    }

    func getImageData(url: URL, success: @escaping (Data) -> Void, failure: @escaping (Error) -> Void) {
    }

    func getRepositoriesList(language: CodeLanguage, page: Int, sortBy: SortType, success: @escaping ([Repository]) -> Void, failure: @escaping (Error) -> Void) {
    }
}
