//
//  ServicesProtocol.swift
//  teste-safra
//
//  Created by Gabriel Sousa on 10/04/21.
//

import Foundation

enum CodeLanguage: String {
    case swift = "swift"
    case java = "java"
    case kotlin = "kotlin"
}

protocol ServicesProtocol: AnyObject {
    func getRepositoriesList(language: CodeLanguage, page: Int, success: @escaping([Repository]) -> Void, failure: @escaping(Error) -> Void)
}
