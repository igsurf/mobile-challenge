//
//  PullRequest.swift
//  teste-safra
//
//  Created by Gabriel Sousa on 12/04/21.
//

import Foundation

struct PullRequest: Codable {
    let state: String
    let title: String
    let user: Owner
    let body: String
}
