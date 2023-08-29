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

    func getSelectedRepositoryName(position: Int) -> String {
        getRepository(position: position).name
    }

    func getPullRequestsList(position: Int, success: @escaping([PullRequest]) -> Void, failure: @escaping(Error?) -> Void) {
        let repository = getRepository(position: position)
        let urlString = parsePullRequestURLString(url: repository.pullsURL)
        guard let url = URL(string: urlString) else {
            failure(nil)
            return
        }
        services.getPullRequests(url: url,
                                 success: { data in
                                    success(data)
                                 },
                                 failure: { error in
                                    failure(error)
                                 })
    }

    // MARK: - Private Methods

    private func fetchRepositoriesList(sortBy: SortType = .stars, success: @escaping([Repository]) -> Void, failure: @escaping(Error) -> Void) {
        guard let language = currentLanguage else {
            return
        }
        services.getRepositoriesList(
            language: language,
            page: currentPage,
            sortBy: sortBy,
            success: { repositories in
                success(repositories)
            },
            failure: { error in
                failure(error)
            })
    }

    private func parsePullRequestURLString(url: String) -> String {
        let trash = "{/number}"
        return url.replacingOccurrences(of: trash, with: String.empty)
    }
}
