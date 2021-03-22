//
//  RepositoryEntity+CoreDataProperties.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 16/03/21.
//
//

import Foundation
import CoreData


extension RepositoryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RepositoryEntity> {
        return NSFetchRequest<RepositoryEntity>(entityName: "Repository")
    }

    @NSManaged public var descript: String?
    @NSManaged public var forks: Int32
    @NSManaged public var forksCount: Int32
    @NSManaged public var fullName: String?
    @NSManaged public var id: Int32
    @NSManaged public var isPrivate: Bool
    @NSManaged public var name: String?
    @NSManaged public var ownerAvatar: String?
    @NSManaged public var ownerLogin: String?
    @NSManaged public var ownerUserType: String?
    @NSManaged public var pullRequestsURL: String?
    @NSManaged public var score: Float
    @NSManaged public var stargazersCount: Int32
    @NSManaged public var pullRequests: NSSet?

}

// MARK: Generated accessors for pullRequests
extension RepositoryEntity {

    @objc(addPullRequestsObject:)
    @NSManaged public func addToPullRequests(_ value: PullRequestEntity)

    @objc(removePullRequestsObject:)
    @NSManaged public func removeFromPullRequests(_ value: PullRequestEntity)

    @objc(addPullRequests:)
    @NSManaged public func addToPullRequests(_ values: NSSet)

    @objc(removePullRequests:)
    @NSManaged public func removeFromPullRequests(_ values: NSSet)

}

extension RepositoryEntity : Identifiable {

}
