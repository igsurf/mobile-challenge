//
//  RepositoryModel.swift
//  GithubJavaPopV3
//
//  Created by Suh on 04/07/22.
//

import Foundation

struct Repository: Codable {
    var name: String
    var description: String
    var stargazersCount: String
    var forks: String
    var owner: Owner
}

extension Repository {
    var ownerAvatarUrl: String {
        owner.avatarUrl
    }
    
    var ownerLogin: String {
        owner.login
    }
}

