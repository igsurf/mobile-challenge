//
//  LicenseResponseModel.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 22/02/21.
//

import Foundation

struct LicenseResponseModel: Codable {
    var key: String?
    var name: String?
    var spdxId: String?
    var url: String?
    var nodeId: String?
    
    enum CondingKeys: String, CodingKey {
        case key
        case name
        case spdxId = "spdx_id"
        case url
        case nodeId = "node_id"
    }
}
