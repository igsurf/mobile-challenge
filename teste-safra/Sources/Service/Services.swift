//
//  Services.swift
//  teste-safra
//
//  Created by Gabriel Sousa on 10/04/21.
//

import Foundation
import SDKGithubServices

class Services: ServicesProtocol {
    func getRepositoriesList(language: CodeLanguage, page: Int, success: @escaping ([Repository]) -> Void, failure: @escaping (Error) -> Void) {
        SDKGithubServices.Services.shared.getRepositories(
            language: language,
            page: page,
            success: { data in
                DataUnwraper.unwrapModel(
                    of: RepositoriesList.self,
                    data: data,
                    success: { list in
                        success(list.repositories)
                    }, failure: { error in
                        failure(error)
                    })
                }, failure: { error in
                    failure(error)
            })
    }
}
