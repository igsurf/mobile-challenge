//
//  RepositoriesListViewModel.swift
//  teste-safra
//
//  Created by Gabriel Sousa on 10/04/21.
//

import Foundation

class RepositoriesListViewModel {

    // MARK: - Private Properties

    private let services: ServicesProtocol
    private var currentPage = 0
    private var repositories: [Repository] = []
    private var currentLanguage: CodeLanguage?

    // MARK: - Life Cycle

    init(services: ServicesProtocol = Services()) {
        self.services = services
    }

    // MARK: - Public Methods

    func getRepositoriesList(language: CodeLanguage, success: @escaping() -> Void, failure: @escaping(Error) -> ()) {
        let isTheSamePage = changePage(language: language)
        self.services.getRepositoriesList(
            language: language,
            page: currentPage,
            success: { repositories in
                if !isTheSamePage {
                    self.repositories.removeAll()
                }
                self.repositories += repositories
                success()
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

    var repositoriesCount: Int {
        repositories.count
    }

    func getRepository(position: Int) -> Repository {
        repositories[position]
    }

    private func changePage(language: CodeLanguage) -> Bool {
        guard let currentLanguage = currentLanguage else {
            self.currentLanguage = language
            currentPage = 1
            return false
        }
        let isTheSameLanguage = language == currentLanguage
        isTheSameLanguage ? (currentPage = 1) : (currentPage += 1)
        self.currentLanguage = language
        return isTheSameLanguage
    }
}
