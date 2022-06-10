//
//  Owner.swift
//  GithubJavaPopV2
//
//  Created by Suh on 09/06/22.
//

import Foundation

struct Owner: Codable {
    var login: String
    var avatarUrl: String
    
}

extension Owner {
    static func fixture(login: String = "MariMaria", avatarUrl: String = "https://trello.com/b/KTaSOgYI/githubapi") -> Owner {
        Owner(
            login: login,
            avatarUrl: avatarUrl
        )
        
    }
}
