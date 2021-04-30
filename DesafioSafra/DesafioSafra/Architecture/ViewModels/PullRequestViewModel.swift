//
//  PullRequestViewModel.swift
//  DesafioSafra
//
//  Created by Renato Ferraz on 28/04/21.
//

import Foundation

struct PullRequestViewModel {
    
    var pullrequest: [PullRequest] = []
    let apiPullrequest: PullsApi?
    let apiUser: UsersAPI?
    
    func getPulls(urlString: String, completion: @escaping (Result<[PullRequest], Error>) ->()) {
        apiPullrequest?.getPulls(urlString: urlString, completion: { result in
            switch result {
            case .success(let pulls):
                completion(.success(pulls))
            case .failure(let error):
                debugPrint(error)
                completion(.failure(error))
            }
        })
    }
    
    func getUser(username: String, completion: @escaping (User?)->()) {
        apiUser?.getUser(username: username, completion: { result in
            switch result {
            case .success(let user):
                completion(user)
            case .failure(let error):
                completion(nil)
                debugPrint(error)
            }
        })
    }
}
