//
//  RepositoryResponseModel.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 22/02/21.
//

import Foundation

struct RepositoryResponseModel: Codable {
    
    var id: Int?
    var nodeId: String?
    var name: String?
    var fullName: String?
    var isPrivate: Bool = false
    var owner: UserResponseModel?
    var htmlUrl: String?
    var description: String?
    var fork: Bool = false
    var url: String?
    var forksUrl: String?
    var keysUrl: String?
    var collaboratorsUrl: String?
    var teamsUrl: String?
    var hooksUrl: String?
    var issueEventsUrl: String?
    var eventsUrl: String?
    var assigneesUrl: String?
    var branchesUrl: String?
    var tagsUrl: String?
    var blobsUrl: String?
    var gitTagsUrl: String?
    var gitRefsUrl: String?
    var treesUrl: String?
    var statusesUrl: String?
    var languagesUrl: String?
    var stargazersUrl: String?
    var contributorsUrl: String?
    var subscribersUrl: String?
    var subscriptionUrl: String?
    var commitsUrl: String?
    var gitCommitsUrl: String?
    var commentsUrl: String?
    var issueCommentUrl: String?
    var contentsUrl: String?
    var compareUrl: String?
    var mergesUrl: String?
    var archiveUrl: String?
    var downloadsUrl: String?
    var issuesUrl: String?
    var pullsUrl: String?
    var milestonesUrl: String?
    var notificationsUrl: String?
    var labelsUrl: String?
    var releasesUrl: String?
    var deploymentsUrl: String?
    var createdAt: String?
    var updatedAt: String?
    var pushedAt: String?
    var gitUrl: String?
    var sshUrl: String?
    var cloneUrl: String?
    var svnUrl: String?
    var homepage: String?
    var size: Int?
    var stargazersCount: Int?
    var watchersCount: Int?
    var language: String?
    var hasIssues: Bool = false
    var hasProjects: Bool = false
    var hasDownloads: Bool = false
    var hasWiki: Bool = false
    var hasPages: Bool = false
    var forksCount: Int?
    var mirrorUrl: String?
    var archived: Bool = false
    var disabled: Bool = false
    var openIssuesCount: Int?
    var license: LicenseResponseModel?
    var forks: Int?
    var openIssues: Int?
    var watchers: Int?
    var defaultBranch: String?
    var score: Float?
    
    enum CodingKeys: String, CodingKey {
        case id
        case nodeId = "node_id"
        case name
        case fullName = "full_name"
        case isPrivate = "private"
        case owner
        case htmlUrl = "html_url"
        case description
        case fork
        case url
        case forksUrl = "forks_url"
        case keysUrl = "keys_url"
        case collaboratorsUrl = "collaborators_url"
        case teamsUrl = "teams_url"
        case hooksUrl = "hooks_url"
        case issueEventsUrl = "issue_events_url"
        case eventsUrl = "events_url"
        case assigneesUrl = "assignees_url"
        case branchesUrl = "branches_url"
        case tagsUrl = "tags_url"
        case blobsUrl = "blobs_url"
        case gitTagsUrl = "git_tags_url"
        case gitRefsUrl = "git_refs_url"
        case treesUrl = "trees_url"
        case statusesUrl = "statuses_url"
        case languagesUrl = "languages_url"
        case stargazersUrl = "stargazers_url"
        case contributorsUrl = "contributors_url"
        case subscribersUrl = "subscribers_url"
        case subscriptionUrl = "subscription_url"
        case commitsUrl = "commits_url"
        case gitCommitsUrl = "git_commits_url"
        case commentsUrl = "comments_url"
        case issueCommentUrl = "issue_comment_url"
        case contentsUrl = "contents_url"
        case compareUrl = "compare_url"
        case mergesUrl = "merges_url"
        case archiveUrl = "archive_url"
        case downloadsUrl = "downloads_url"
        case issuesUrl = "issues_url"
        case pullsUrl = "pulls_url"
        case milestonesUrl = "milestones_url"
        case notificationsUrl = "notifications_url"
        case labelsUrl = "labels_url"
        case releasesUrl = "releases_url"
        case deploymentsUrl = "deployments_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pushedAt = "pushed_at"
        case gitUrl = "git_url"
        case sshUrl = "ssh_url"
        case cloneUrl = "clone_url"
        case svnUrl = "svn_url"
        case homepage
        case size
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case language
        case hasIssues = "has_issues"
        case hasProjects = "has_projects"
        case hasDownloads = "has_downloads"
        case hasWiki = "has_wiki"
        case hasPages = "has_pages"
        case forksCount = "forks_count"
        case mirrorUrl = "mirror_url"
        case archived
        case disabled
        case openIssuesCount = "open_issues_count"
        case license
        case forks
        case openIssues = "open_issues"
        case watchers
        case defaultBranch = "default_branch"
        case score
    }
}
