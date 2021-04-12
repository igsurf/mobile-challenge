//
//  MockServices.swift
//  teste-safra
//
//  Created by Gabriel Sousa on 11/04/21.
//

import UIKit

class MockServices: ServicesProtocol {

    // MARK: - Constants

    private let jsonExtension = "json"

    // MARK: - Public Methods

    func getPullRequests(url: URL, success: @escaping ([PullRequest]) -> Void, failure: @escaping (Error) -> Void) {
        let path = "pulls"

        if let url = Bundle(for: MockServices.self).url(forResource: path, withExtension: jsonExtension) {
            do {
                let data = try Data(contentsOf: url, options: .mappedIfSafe)
                DataUnwraper.unwrapModel(of: [PullRequest].self,
                                         data: data,
                                         success: { list in
                                            success(list)
                                         },
                                         failure: { error in
                                            failure(error)
                                         })
            } catch {
                failure(error)
            }
        }
    }
    
    func getUser(username: String, success: @escaping (Owner) -> Void, failure: @escaping (Error) -> Void) {
        let path = "user"

        if let url = Bundle(for: MockServices.self).url(forResource: path, withExtension: jsonExtension) {
            do {
                let data = try Data(contentsOf: url, options: .mappedIfSafe)
                DataUnwraper.unwrapModel(of: Owner.self,
                                         data: data,
                                         success: { owner in
                                            success(owner)
                                         },
                                         failure: { error in
                                            failure(error)
                                         })
            } catch {
                failure(error)
            }
        }
    }

    func getImageData(url: URL, success: @escaping (Data) -> Void, failure: @escaping (Error) -> Void) {
    }

    func getRepositoriesList(language: CodeLanguage, page: Int, sortBy: SortType, success: @escaping ([Repository]) -> Void, failure: @escaping (Error) -> Void) {
        let path = "repo"

        if let url = Bundle(for: MockServices.self).url(forResource: path, withExtension: jsonExtension) {
            do {
                let data = try Data(contentsOf: url, options: .mappedIfSafe)
                DataUnwraper.unwrapModel(of: RepositoriesList.self,
                                         data: data,
                                         success: { list in
                                            success(list.repositories)
                                         },
                                         failure: { error in
                                            failure(error)
                                         })
            } catch {
                failure(error)
            }
        }
    }
}
