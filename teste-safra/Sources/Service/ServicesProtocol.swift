//
//  ServicesProtocol.swift
//  teste-safra
//
//  Created by Gabriel Sousa on 10/04/21.
//

import UIKit

enum CodeLanguage: String {
    case swift = "swift"
    case java = "java"
    case kotlin = "kotlin"
}

protocol ServicesProtocol: AnyObject {
    func getRepositoriesList(language: CodeLanguage, page: Int, success: @escaping([Repository]) -> Void, failure: @escaping(Error) -> Void)
    func getUser(username: String, success: @escaping(Owner) -> Void, failure: @escaping(Error) -> Void)
    func getImageData(url: URL, success: @escaping(Data) -> Void, failure: @escaping(Error) -> Void)
}
