//
//  PullRequestCellViewModel.swift
//  teste-safra
//
//  Created by Gabriel Sousa on 12/04/21.
//

import UIKit

class PullRequestCellViewModel {

    // MARK: - Private Properties

    private let model: PullRequest
    private let service: ServicesProtocol

    // MARK: - Life Cycle

    init(model: PullRequest, service: ServicesProtocol = Services()) {
        self.model = model
        self.service = service
    }

    // MARK: - Public Methods

    var title: String {
        model.title
    }

    var body: String {
        model.body
    }

    var userName: String {
        model.user.login ?? .empty
    }

    func getUserFullName(completion: @escaping(String?) -> Void) {
        getUserDetails { user in
            completion(user?.name)
        }
    }

    func getImage(completion: @escaping(UIImage) -> Void) {
        guard let url = URL(string: model.user.avatarURL) else {
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

    // MARK: - Private Methods

    private func getUserDetails(completion: @escaping(Owner?) -> Void){
        service.getUser(
            username: model.user.login ?? .empty,
            success: { owner in
                completion(owner)
            }, failure: { error in
                completion(nil)
        })
    }
}
