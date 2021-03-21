//
//  MilestoneReponseModel.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 15/03/21.
//

import Foundation

struct MilestoneReponseModel: Codable {
    var url: String?
    var htmlUrl: String?
    var labelsUrl: String?
    var id: Int?
    var nodeId: String?
    var number: Int?
    var title: String?
    var description: String?
    var creator: UserResponseModel?
    var openIssues: Int?
    var closedIssues: Int?
    var state: String?
    var createdAt: String?
    var updatedAt: String?
    var dueOn: String?
    var closedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case url
        case htmlUrl = "html_url"
        case labelsUrl = "labels_url"
        case id
        case nodeId = "node_id"
        case number
        case title
        case description
        case creator
        case openIssues = "open_issues"
        case closedIssues = "closed_issues"
        case state
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case dueOn = "due_on"
        case closedAt = "closed_at"
    }
}
