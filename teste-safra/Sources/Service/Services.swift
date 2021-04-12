//
//  Services.swift
//  teste-safra
//
//  Created by Gabriel Sousa on 10/04/21.
//

import Foundation
import SDKGithubServices

class Services: ServicesProtocol {

    // MARK: - Private Properties

    private let service = SDKGithubServices.Services.shared

    // MARK: - Public Methods

    func getUser(username: String, success: @escaping (Owner) -> Void, failure: @escaping (Error) -> Void) {
        service.getUser(
            username: username,
            success: { data in
                DataUnwraper.unwrapModel(
                    of: Owner.self,
                    data: data,
                    success: { owner in
                        success(owner)
                    },
                    failure: { error in
                        failure(error)
                    })
            },
            failure: { error in
                failure(error)
            })
    }
    
    func getImageData(url: URL, success: @escaping (Data) -> Void, failure: @escaping (Error) -> Void) {
        service.request(
            url: url,
            success: { data in
                success(data)
            },
            failure: { error in
                failure(error)
            })
    }
    
    func getRepositoriesList(language: CodeLanguage, page: Int, sortBy: SortType, success: @escaping ([Repository]) -> Void, failure: @escaping (Error) -> Void) {
        service.getRepositories(
            language: language.rawValue,
            page: page,
            sortBy: sortBy.rawValue,
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

    func getPullRequests(url: URL, success: @escaping ([PullRequest]) -> Void, failure: @escaping (Error) -> Void) {
        service.request(url: url,
                        success: { data in
                            DataUnwraper.unwrapModel(
                                of: [PullRequest].self,
                                data: data,
                                success: { list in
                                    success(list)
                                },
                                failure: { error in
                                    failure(error)
                                })
                        },
                        failure: { error in
                            failure(error)
                        })
    }
}
