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
    @objc var ownerProfile: String?
    @objc var ownerImage: String?
    @objc var ownerName: String?
    @objc var ownerUsername: String?
    @objc var starsCount: NSNumber?
    @objc var forksCount: NSNumber?
    @objc var fullName: String?
    
    static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]! {
        return [ "repositoryName" : "name",
                 "descriptionRepository" : "description",
                 "ownerProfile" : "owner.url",
                 "ownerUsername": "owner.login",
                 "ownerImage": "owner.avatar_url",
                 "starsCount" : "stargazers_count",
                 "forksCount" : "forks_count",
                 "fullName": "full_name"]
    }
}
