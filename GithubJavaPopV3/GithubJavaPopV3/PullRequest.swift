//
//  PullRequest.swift
//  GithubJavaPopV3
//
//  Created by Suh on 06/07/22.
//

import Foundation

struct PullRequest: Codable {
    var title: String
    var user: Owner
    var body: String?
    var createdAt: String
    var htmlUrl: String
    
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
        title: String = "Eu te amo tanto!",
        user: Owner = Owner.fixture(),
        body: String? = "Eu amo tanto você que o meu sonho era poder estar ao seu lado o tempo todo. Pois, desde que você faz parte da minha vida, tudo mudou para melhor, tudo ficou perfeito. Você trouxe o que estava me faltando; você me completa e me faz muito feliz. Eu te amo tanto!",
        createdAt: String = "22-06-2022 HHMM") -> PullRequest {
            return PullRequest(
                title: title,
                user: user,
                body: body,
                createdAt: createdAt,
                htmlUrl: "")
    }
}
#endif
