//
//  RepositoryCellViewModel.swift
//  teste-safra
//
//  Created by Gabriel Sousa on 11/04/21.
//

import Foundation

class RepositoryCellViewModel {

    // MARK: - Private Properties

    private let model: Repository

    // MARK: - Life Cycle

    init(model: Repository) {
        self.model = model
    }

    // MARK: - Private Methods

    var repositoryName: String {
        model.name
    }

    var repositoryDesc: String {
        model.itemDescription ?? .empty
    }

    var forksCountText: String {
        String(model.forks)
    }

    var username: String {
        model.owner.login
    }
}
