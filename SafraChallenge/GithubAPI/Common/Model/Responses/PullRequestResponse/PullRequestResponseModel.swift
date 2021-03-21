//
//  PullRequestResponseModel.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 27/02/21.
//

import Foundation

struct PullRequestResponseModel: Codable {
    var url: String?
    var id: Int?
    var nodeId: String?
    var htmlUrl: String?
    var diffUrl: String?
    var patchUrl: String?
    var issueUrl: String?
    var number: Int?
    var state: String?
    var locked: Bool = false
    var title: String?
    var user: UserResponseModel?
    var body: String?
    var createdAt: String?
    var updatedAt: String?
    var closedAt: String?
    var mergedAt: String?
    var mergeCommitSha: String?
    var assignee: UserResponseModel?
    var assignees: [UserResponseModel]?
    var requestedReviewers: [UserResponseModel]?
    var requestedTeams: [String]?
    var labels: [LabelResponseModel]?
    var milestone: MilestoneReponseModel?
    var draft: Bool = false
    var commitsUrl: String?
    var reviewCommentsUrl: String?
    var reviewCommentUrl: String?
    var commentsUrl: String?
    var statusesUrl: String?
    var head: BaseHeadResponseModel?
    var base: BaseHeadResponseModel?
    var links: LinksResponseModel?
    var authorAssociation: String?
    var autoMerge: Bool? = false
    var activeLockReason: String?
    
    enum CodingKeys: String, CodingKey {
        case url
        case id
        case nodeId = "node_id"
        case htmlUrl = "html_url"
        case diffUrl = "diff_url"
        case patchUrl = "patch_url"
        case issueUrl = "issue_url"
        case number
        case state
        case locked
        case title
        case user
        case body
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case closedAt = "closed_at"
        case mergedAt = "merged_at"
        case mergeCommitSha = "merge_commit_sha"
        case assignee
        case assignees
        case requestedReviewers = "requested_reviewers"
        case requestedTeams = "requested_teams"
        case labels
        case milestone
        case draft
        case commitsUrl = "commits_url"
        case reviewCommentsUrl = "review_comments_url"
        case reviewCommentUrl = "review_comment_url"
        case commentsUrl = "comments_url"
        case statusesUrl = "statuses_url"
        case head
        case base
        case links = "_links"
        case authorAssociation = "author_association"
        case autoMerge = "auto_merge"
        case activeLockReason = "active_lock_reason"
    }
}
