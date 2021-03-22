//
//  LinksResponseModel.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 27/02/21.
//

import Foundation

struct LinksResponseModel: Codable {
    var selfLink: LinkResponseModel?
    var html: LinkResponseModel?
    var issue: LinkResponseModel?
    var comments: LinkResponseModel?
    var reviewComments: LinkResponseModel?
    var reviewComment: LinkResponseModel?
    var commits: LinkResponseModel?
    var statuses: LinkResponseModel?
    
    enum CodingKeys: String, CodingKey {
        case selfLink = "self"
        case html
        case issue
        case comments
        case reviewComments = "review_comments"
        case reviewComment = "review_comment"
        case commits
        case statuses
    }
}
