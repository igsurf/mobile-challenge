//
//  User.swift
//  DesafioSafra
//
//  Created by Renato Ferraz on 27/04/21.
//

import Foundation

public struct User: Codable {
    let login: String?
    let id: Int?
    let nodeID: String?
    let avatarURL: URL?
    let name: String?

    private enum CodingKeys: String, CodingKey {
        case login
        case id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case name
    }

    init(
        login: String?,
        id: Int?,
        nodeID: String?,
        avatarURL: URL?,
        name: String?
    ) {
        self.login = login
        self.id = id
        self.nodeID = nodeID
        self.avatarURL = avatarURL
        self.name = name
    }
}
