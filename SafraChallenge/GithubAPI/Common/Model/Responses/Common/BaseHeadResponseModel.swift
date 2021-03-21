//
//  BaseHeadResponseModel.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 27/02/21.
//

import Foundation

struct BaseHeadResponseModel: Codable {
    var label: String?
    var ref: String?
    var sha: String?
    var user: UserResponseModel?
    var repo: RepositoryResponseModel?
    
    enum CodingKeys: String, CodingKey {
        case label
        case ref
        case sha
        case user
        case repo
    }
}
