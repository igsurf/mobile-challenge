//
//  PullRequest.swift
//  GithubJavaPopV2
//
//  Created by Suh on 14/06/22.
//

import Foundation


struct PullRequest: Codable {
    let title: String
    let body: String?
    let user: Owner
    let createdAt: String
    let htmlUrl: String
}

extension PullRequest {
    var userLogin: String {
        user.login
    }
    
    var userAvatar: String {
        user.avatarUrl
    }
}

#if DEBUG
extension PullRequest {
    static func fixture(
        title: String = "Até que enfim",
        body: String = "Demorou mais chegou aqui minha filha.... Óh gloriasssss",
        user: Owner = Owner.fixture(),
        createdAt: String = "22 de junho de 2022"
    ) -> PullRequest {
        PullRequest(
            title: title,
            body: body,
            user: user,
            createdAt: createdAt, htmlUrl: ""
        )
    }
}
#endif
