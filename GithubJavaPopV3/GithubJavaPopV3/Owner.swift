//
//  Owner.swift
//  GithubJavaPopV3
//
//  Created by Suh on 04/07/22.
//

import Foundation

struct Owner: Codable {
    var avatarUrl: String
    let login: String
}

extension Owner {
    static func fixture(
        avatarUrl: String = "alhfiuablwebdlgew.png",
        login: String = "SuCris"
    ) -> Owner {
        Owner(
            avatarUrl: avatarUrl,
            login: login
        )
    }
}
