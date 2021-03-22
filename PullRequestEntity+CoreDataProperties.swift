//
//  PullRequestEntity+CoreDataProperties.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 16/03/21.
//
//

import Foundation
import CoreData


extension PullRequestEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PullRequestEntity> {
        return NSFetchRequest<PullRequestEntity>(entityName: "PullRequest")
    }

    @NSManaged public var body: String?
    @NSManaged public var date: String?
    @NSManaged public var ownerAvatar: String?
    @NSManaged public var ownerName: String?
    @NSManaged public var ownerType: String?
    @NSManaged public var state: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var id: Int32
    @NSManaged public var ofRepository: RepositoryEntity?

}

extension PullRequestEntity : Identifiable {

}
