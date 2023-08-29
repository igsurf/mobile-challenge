//
//  Repository.swift
//  teste-safra
//
//  Created by Gabriel Sousa on 10/04/21.
//

import Foundation

struct RepositoriesList: Codable {
    let repositories: [Repository]

    enum CodingKeys: String, CodingKey {
        case repositories = "items"
    }
}

struct Repository: Codable {
    let name, fullName: String
    let owner: Owner
    let itemDescription: String?
    let stargazersCount: Int
    let forksCount: Int
    let forks: Int
    let pullsURL: String

    enum CodingKeys: String, CodingKey {
        case name, forks
        case fullName = "full_name"
        case owner
        case itemDescription = "description"
        case forksCount = "forks_count"
        case stargazersCount = "stargazers_count"
        case pullsURL = "pulls_url"
    }
}
