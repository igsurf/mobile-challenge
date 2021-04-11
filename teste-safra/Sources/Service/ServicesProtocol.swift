//
//  ServicesProtocol.swift
//  teste-safra
//
//  Created by Gabriel Sousa on 10/04/21.
//

import Foundation
import SDKGithubServices

protocol ServicesProtocol: AnyObject {
    func getRepositoriesList(language: CodeLanguage, page: Int, success: @escaping([Repository]) -> Void, failure: @escaping(Error) -> Void)
}
