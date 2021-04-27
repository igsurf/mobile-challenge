//
//  OwnerModel.swift
//  DesafioSafra
//
//  Created by Renato Ferraz on 27/04/21.
//

import Foundation

public struct Owner: Codable {
    let login: String?
    let id: Int?
    let nodeID: String?
    let avatarURL: URL?

    private enum CodingKeys: String, CodingKey {
        case login
        case id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
    }

    init(
        login: String?,
        id: Int?,
        nodeID: String?,
        avatarURL: URL?
    ) {
        self.login = login
        self.id = id
        self.nodeID = nodeID
        self.avatarURL = avatarURL
    }
}
