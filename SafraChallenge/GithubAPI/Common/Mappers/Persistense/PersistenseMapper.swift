//
//  PersistenseMapper.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 16/03/21.
//

import Foundation

class PersistenseMapper {
    public static let instance = PersistenseMapper()
    
    private init(){}
    
    func parse(from repositoryView: RepositoryView, to repositoryEntity: RepositoryEntity) -> RepositoryEntity {
        let repository = repositoryEntity
        
        repository.descript = repositoryView.descript
        repository.forks = Int32(repositoryView.forks)
        repository.forksCount = Int32(repositoryView.forksCount)
        repository.fullName = repositoryView.fullName
        repository.id = Int32(repositoryView.id)
        repository.isPrivate = repositoryView.isPrivate
        repository.name = repositoryView.name
        repository.ownerAvatar = repositoryView.ownerAvatar
        repository.ownerLogin = repositoryView.ownerLogin
        repository.ownerUserType = repositoryView.ownerUserType
        repository.pullRequestsURL = repositoryView.pullRequestsURL
        repository.score = repositoryView.score
        repository.stargazersCount = Int32(repositoryView.stargazersCount)
        
        return repository
    }
    
    func parse(from pullRequestView: PullRequestView, to pullRequestEntity: PullRequestEntity, repository: RepositoryEntity) -> PullRequestEntity {
        let pullRequest = pullRequestEntity
        
        pullRequest.id = Int32(pullRequestView.id)
        pullRequest.title = pullRequestView.title
        pullRequest.body = pullRequestView.body
        pullRequest.date = pullRequestView.date
        pullRequest.ownerAvatar = pullRequestView.ownerAvatar
        pullRequest.ownerName = pullRequestView.ownerName
        pullRequest.ownerType = pullRequestView.ownerType
        pullRequest.state = pullRequestView.state
        pullRequest.url = pullRequestView.url
        pullRequest.ofRepository = repository
        
        return pullRequest
    }
    
    func parse(from repositoryEntity: RepositoryEntity) -> RepositoryView {
        var repository = RepositoryView()
        
        if let descript = repositoryEntity.descript {
            repository.descript = descript
        }
        
        repository.forks = Int(repositoryEntity.forks)
        repository.forksCount = Int(repositoryEntity.forksCount)
        
        if let fullName = repositoryEntity.fullName {
            repository.fullName = fullName
        }
        
        repository.id = Int(repositoryEntity.id)
        repository.isPrivate = repositoryEntity.isPrivate
        
        if let name = repositoryEntity.name {
            repository.name = name
        }
        
        if let ownerAvatar = repositoryEntity.ownerAvatar {
            repository.ownerAvatar = ownerAvatar
        }
        
        if let ownerLogin = repositoryEntity.ownerLogin {
            repository.ownerLogin = ownerLogin
        }
        
        if let ownerUserType = repositoryEntity.ownerUserType {
            repository.ownerUserType = ownerUserType
        }
        
        if let pullRequestsURL = repositoryEntity.pullRequestsURL {
            repository.pullRequestsURL = pullRequestsURL
        }
        
        repository.score = repositoryEntity.score
        repository.stargazersCount = Int(repositoryEntity.stargazersCount)
        
        if let arr = repositoryEntity.pullRequests?.allObjects as? [PullRequestEntity] {
            arr.forEach({ item in
                let pr = parse(from: item)
                repository.pullRequests.append(pr)
            })
        }
        
        return repository
    }
    
    func parse(from pullrequestEntity: PullRequestEntity) -> PullRequestView {
        var pullRequest = PullRequestView()
        
        pullRequest.id = Int(pullrequestEntity.id)
        pullRequest.title = pullrequestEntity.title ?? ""
        pullRequest.body = pullrequestEntity.body ?? ""
        pullRequest.date = pullrequestEntity.date ?? ""
        pullRequest.ownerAvatar = pullrequestEntity.ownerAvatar ?? ""
        pullRequest.ownerName = pullrequestEntity.ownerName ?? ""
        pullRequest.ownerType = pullrequestEntity.ownerType ?? ""
        pullRequest.state = pullrequestEntity.state ?? ""
        pullRequest.url = pullrequestEntity.url ?? ""
        
//        if let repo = pullrequestEntity.ofRepository {
//            pullRequest.ofRepository = parse(from: repo)
//        }
        
        return pullRequest
    }
}
