//
//  RepositoryCellViewModel.swift
//  teste-safra
//
//  Created by Gabriel Sousa on 11/04/21.
//

import UIKit

class RepositoryCellViewModel {

    // MARK: - Private Properties

    private let model: Repository
    private let service: ServicesProtocol

    // MARK: - Public Properties

    var userDetails: Owner?

    // MARK: - Life Cycle

    init(model: Repository, service: ServicesProtocol) {
        self.model = model
        self.service = service
    }

    // MARK: - Private Methods

    var starCountsText: String {
        String(model.stargazersCount)
    }

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

    func getUserDetails(success: @escaping(Owner) -> Void, failure: @escaping(Error) -> Void){
        service.getUser(
            username: model.owner.login,
            success: { owner in
                self.userDetails = owner
                success(owner)
            }, failure: { error in
                failure(error)
        })
    }

    func getImage(success: @escaping(UIImage) -> Void, failure: @escaping(Error) -> Void) {
        guard let url = URL(string: model.owner.avatarURL) else {
            success(UIImage())
            return
        }
        service.getImageData(
            url: url,
            success: { data in
                let image = UIImage(data: data) ?? UIImage()
                success(image)
            },
            failure: { error in
                failure(error)
            })
    }
}
