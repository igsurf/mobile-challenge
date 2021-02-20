//
//  RepositoriesModel.swift
//  mobile-challenger
//
//  Created by Leonardo Sugano on 20/02/21.
//

import Foundation
import Mantle

class RepositoriesModel: MTLModel, MTLJSONSerializing {
    @objc var repositoryName: String?
    @objc var descriptionRepository: String?
    @objc var ownerProfile: String? //url do perfil
    @objc var ownerImage: String?
    @objc var ownerName: String?
    @objc var ownerUsername: String?
    @objc var starsCount: NSNumber?
    @objc var forksCount: NSNumber?
    
    static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]! {
        return [ "repositoryName" : "name",
                 "descriptionRepository" : "description",
                 "ownerProfile" : "owner.url",
                 "ownerImage": "owner.avatar_url",
                 "starsCount" : "stargazers_count",
                 "forksCount" : "forks_count"]
    }
}
