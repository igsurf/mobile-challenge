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

    // MARK: - Life Cycle

    init(model: Repository, service: ServicesProtocol) {
        self.model = model
        self.service = service
    }

    // MARK: - Public Methods

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
        model.owner.login ?? .empty
    }

    func getImage(completion: @escaping(UIImage) -> Void) {
        guard let url = URL(string: model.owner.avatarURL) else {
            completion(UIImage())
            return
        }
        service.getImageData(
            url: url,
            success: { data in
                let image = UIImage(data: data) ?? UIImage()
                completion(image)
            },
            failure: { _ in
                completion(UIImage())
            })
    }

    func getUserFullName(completion: @escaping(String?) -> Void) {
        getUserDetails { user in
            completion(user?.name)
        }
    }

    // MARK: - Private Methods

    private func getUserDetails(completion: @escaping(Owner?) -> Void){
        service.getUser(
            username: model.owner.login ?? .empty,
            success: { owner in
                completion(owner)
            }, failure: { error in
                completion(nil)
        })
    }
}
