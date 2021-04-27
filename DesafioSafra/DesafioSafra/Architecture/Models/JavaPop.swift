//
//  JavaPopModel.swift
//  DesafioSafra
//
//  Created by Renato Ferraz on 27/04/21.
//

import Foundation

public struct JavaPop: Codable {
    let totalCount: Int?
    let incompleteResults: Bool?
    let items: [Items]?

    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }

    init(
        totalCount: Int?,
        incompleteResults: Bool?,
        items: [Items]?
    ) {
        self.totalCount = totalCount
        self.incompleteResults = incompleteResults
        self.items = items
    }
}
