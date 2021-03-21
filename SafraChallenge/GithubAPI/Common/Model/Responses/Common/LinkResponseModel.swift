//
//  LinkResponseModel.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 27/02/21.
//

import Foundation

struct LinkResponseModel: Codable {
    var href: String?
    
    enum CondingKeys: String, CodingKey {
        case href
    }
}
