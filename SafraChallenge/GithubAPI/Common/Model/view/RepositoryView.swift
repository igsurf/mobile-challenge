//
//  RepositoryView.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 11/03/21.
//

import Foundation

public struct RepositoryView {
    var descript: String = ""
    var forks: Int = 0
    var forksCount: Int = 0
    var fullName: String = ""
    var id: Int = 0
    var isPrivate: Bool = false
    var name: String = ""
    var ownerAvatar: String = ""
    var ownerLogin: String = ""
    var ownerUserType: String = ""
    var pullRequestsURL: String = ""
    var score: Float = 0
    var stargazersCount: Int = 0
    var pullRequests: [PullRequestView] = []
}
