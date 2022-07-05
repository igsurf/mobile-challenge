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
    var stargazersCount: Int
    var forks: Int
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

extension Repository {
    static func fixture(
        name: String = "Suelen Cristina",
        description: String = "São pessoas sensíveis, sonhadoras, empáticas, pacientes, calmas, intuitivas, românticas, generosas, místicas e amáveis. “Captam toda a energia do ambiente como esponjas, o que os leva a sentir muitas coisas que não são suas.",
        stargazersCount: Int = 1212,
        forks: Int = 12121,
        owner: Owner = Owner.fixture()
    ) -> Repository {
        Repository(name: name, description: description, stargazersCount: stargazersCount, forks: forks, owner: owner)
    }
}
