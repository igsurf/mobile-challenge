//
//  RepositoriesListViewModel.swift
//  teste-safra
//
//  Created by Gabriel Sousa on 10/04/21.
//

import Foundation
import SDKGithubServices

class RepositoriesListViewModel {

    // MARK: - Private Properties

    private let services: ServicesProtocol

    // MARK: - Life Cycle

    init(services: ServicesProtocol = Services()) {
        self.services = services
    }

    // MARK: - Public Methods

    func getRepositoriesList(language: CodeLanguage, page: Int, success: @escaping([Repository]) -> Void, failure: @escaping(Error) -> Void) {
            self.services.getRepositoriesList(
                language: language,
                page: page,
                success: { repositories in
                    success(repositories)
                },
                failure: { error in
                    failure(error)
                })
    }

    var languageOptions: [CodeLanguage] {
        [CodeLanguage.java,
         CodeLanguage.kotlin,
         CodeLanguage.swift]
    }
}
