//
//  ItemsModel.swift
//  DesafioSafra
//
//  Created by Renato Ferraz on 27/04/21.
//

import Foundation

public struct Items: Codable {
   
    let id: Int?
    let nodeID: String?
    let name: String?
    let owner: Owner?
    let description: String?
    let pullsURL: String?
    let stargazersCount: Int?
    let forksCount: Int?

    private enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case owner
        case description
        case pullsURL = "pulls_url"
        case stargazersCount = "stargazers_count"
        case forksCount = "forks_count"
    }

    init(
        id: Int?,
        nodeID: String?,
        name: String?,
        owner: Owner?,
        description: String?,
        pullsURL: String?,
        stargazersCount: Int?,
        forksCount: Int?
    ) {
        self.id = id
        self.nodeID = nodeID
        self.name = name
        self.owner = owner
        self.description = description
        self.pullsURL = pullsURL
        self.stargazersCount = stargazersCount
        self.forksCount = forksCount
    }
}
