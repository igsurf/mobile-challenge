//
//  PullRequest.swift
//  DesafioSafra
//
//  Created by Renato Ferraz on 28/04/21.
//

import Foundation

public struct PullRequest: Codable {

    let url: URL?
    let id: Int?
    let nodeID: String?
    let htmlURL: URL?
    let number: Int?
    let state: String?
    let locked: Bool?
    let title: String?
    let user: User?
    let body: String?

    private enum CodingKeys: String, CodingKey {
        case url
        case id
        case nodeID = "node_id"
        case htmlURL = "html_url"
        case number
        case state
        case locked
        case title
        case user
        case body
    }
}
