//
//  Owner.swift
//  teste-safra
//
//  Created by Gabriel Sousa on 10/04/21.
//

import Foundation

struct Owner: Codable {
    let login: String?
    let avatarURL: String
    let name: String?

    enum CodingKeys: String, CodingKey {
        case login, name
        case avatarURL = "avatar_url"
    }
}
