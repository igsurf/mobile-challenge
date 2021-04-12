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
    private var currentPage = 1
    private var repositories: [Repository] = []
    private var currentLanguage: CodeLanguage?

    // MARK: - Life Cycle

    init(services: ServicesProtocol = Services()) {
        self.services = services
    }

    // MARK: - Public Methods

    func resetList() {
        currentPage = 1
        repositories.removeAll()
    }

    func getRepositoriesList(language: CodeLanguage, success: @escaping() -> Void, failure: @escaping(Error) -> ()) {
        currentPage = 1
        currentLanguage = language
        fetchRepositoriesList (success: { repositories in
            self.repositories.removeAll()
            self.repositories += repositories
            success()
        }, failure: { error in
            failure(error)
        })
    }

    func getRepositoriesListNextPage(success: @escaping() -> Void, failure: @escaping(Error) -> ()) {
        currentPage += 1
        print("uva", currentPage)
        fetchRepositoriesList (success: { repositories in
            self.repositories += repositories
            success()
        }, failure: { error in
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

    // MARK: - Private Methods

    private func fetchRepositoriesList(success: @escaping([Repository]) -> Void, failure: @escaping(Error) -> Void) {
        guard let language = currentLanguage else {
            return
        }
        services.getRepositoriesList(
            language: language,
            page: currentPage,
            success: { repositories in
                success(repositories)
            },
            failure: { error in
                failure(error)
            })
    }
}
