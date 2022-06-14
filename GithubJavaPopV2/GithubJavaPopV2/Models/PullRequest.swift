//
//  PullRequest.swift
//  GithubJavaPopV2
//
//  Created by Suh on 14/06/22.
//

import Foundation


struct PullRequest: Codable {
    var title: String
    var body: String
    var user: Owner
    var createdAt: String
}

extension PullRequest {
    var userLogin: String {
        user.login
    }
    
    var userAvatar: String {
        user.avatarUrl
    }
}

extension PullRequest {
    static func fixture(
        title: String = "Áte que enfim",
        body: String = "Demorou mais chegou aqui minha filha.... Óh gloriasssss",
        user: Owner = Owner.fixture(),
        createdAt: String = "22 de junho de 2022"
    ) -> PullRequest {
        PullRequest(
            title: title,
            body: body,
            user: user,
            createdAt: createdAt
        )
    }
}

