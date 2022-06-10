//
//  Repository.swift
//  GithubJavaPopV2
//
//  Created by Suh on 09/06/22.
//

import Foundation

struct Repository: Codable {
    var name: String
    var description: String
    var stargazersCount: Int
    var forks: Int
    var owner: Owner
    
}

extension Repository {
    var ownerLogin: String {
        owner.login
    }
    var ownerAvatarUrl: String {
        owner.avatarUrl
    }
}

extension Repository {
    static func fixture(name: String = "Maria Aparecida de Jesus",
                        description: String = "Rogai por nos pecadores, na ora da nossa morte, Amem!!",
                        stargazersCount: Int = 1234,
                        forks: Int = 5678,
                        owner: Owner = Owner.fixture()
    ) -> Repository {
        Repository(
            name: name,
            description: description,
            stargazersCount: stargazersCount,
            forks: forks,
            owner: owner
        )
    }
}
