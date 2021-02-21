//
//  PullRequestModel.swift
//  mobile-challenger
//
//  Created by Leonardo Sugano on 20/02/21.
//

import Foundation
import Mantle

class PullRequestModel: MTLModel, MTLJSONSerializing {
    @objc var urlPR: String?
    @objc var titlePR: String?
    @objc var descriptionPR: String?
    @objc var ownerImage: String?
    @objc var ownerUsername: String?
    @objc var createDate: String?
    @objc var state: String?
    
    static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]! {
        return [ "urlPR" : "html_url",
                 "titlePR" : "title",
                 "descriptionPR" : "body",
                 "ownerUsername" : "user.login",
                 "ownerImage": "user.avatar_url",
                 "createDate" : "created_at",
                 "state": "state"]
    }
}
