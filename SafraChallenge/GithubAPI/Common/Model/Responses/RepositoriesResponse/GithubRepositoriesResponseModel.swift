//
//  GithubRepositoriesResponseModel.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 22/02/21.
//

import Foundation

public struct GithubRepositoriesResponseModel: Codable {
    var totalCount: Int?
    var incompleteResults: Bool = false
    var items: [RepositoryResponseModel]?
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}
