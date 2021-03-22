//
//  LabelResponseModel.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 14/03/21.
//

import Foundation

struct LabelResponseModel: Codable {
    var id: Int?
    var nodeId: String?
    var url: String?
    var name: String?
    var color: String?
    var `default`: Bool?
    var description: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case nodeId = "node_id"
        case url
        case name
        case color
        case `default`
        case description
    }
}
