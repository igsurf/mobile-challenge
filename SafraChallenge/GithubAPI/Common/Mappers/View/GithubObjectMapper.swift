//
//  GithubObjectMapper.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 22/02/21.
//

import Foundation
import CoreData

class GithubObjectMapper {
    public static let instance = GithubObjectMapper()
    
    private init() {}
    
    // MARK: Repositories
    func parse(from: GithubRepositoriesResponseModel) -> [RepositoryView] {
        var objects: [RepositoryView] = []
        
        if let items = from.items, items.count > 0 {
            items.forEach({ item in
                let repo = parse(from: item)
                objects.append(repo)
            })
        }
        
        return objects
    }
    
    func parse(from: RepositoryResponseModel) -> RepositoryView {
        var object = RepositoryView()
        
        object.isPrivate = from.isPrivate
        
        if let id = from.id {
            object.id = id
        }
        
        if let name = from.name {
            object.name = name
        }
        
        if let fullName = from.fullName {
            object.fullName = fullName
        }
        
        if let description = from.description {
            object.descript = description
        }
        
        if let stargazersCount = from.stargazersCount {
            object.stargazersCount = stargazersCount
        }
        if let forksCount = from.forksCount {
            object.forksCount = forksCount
        }
        if let forks = from.forks {
            object.forks = forks
        }
        if let score = from.score {
            object.score = score
        }
        if let login = from.owner?.login {
            object.ownerLogin = login
        }
        if let type = from.owner?.type {
            object.ownerUserType = type
        }
        if let avatar = from.owner?.avatarUrl {
            object.ownerAvatar = avatar
        }
        if let url = from.pullsUrl {
            object.pullRequestsURL = url
        }
        
        return object
    }
    
    // MARK: Pull Requests
    func parse(from: [PullRequestResponseModel]) -> [PullRequestView] {
        var object: [PullRequestView] = []
        
        if from.count > 0 {
            from.forEach({ item in
                let repo = parse(from: item)
                object.append(repo)
            })
        }
        
        return object
    }
    
    func parse(from: PullRequestResponseModel) -> PullRequestView {
        var object = PullRequestView()
        if let owner = from.user {
            object.ownerName = owner.login ?? ""
            object.ownerAvatar = owner.avatarUrl ?? ""
            object.ownerType = owner.type ?? ""
        }
        
        if let id = from.id {
            object.id = id
        }
        
        if let title = from.title {
            object.title = title
        }
        
        if let strDate = from.createdAt, let date = strDate.toDate() {
            object.date = date.toString()
        }
        
        if let body = from.body {
            object.body = body
        }
        
        if let url = from.htmlUrl {
            object.url = url
        }
        
        if let base = from.base, let repo = base.repo {
            object.ofRepository = parse(from: repo)
        }
        
        if let state = from.state {
            object.state = state
        }
        
        return object
    }
}
