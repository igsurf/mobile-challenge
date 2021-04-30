//
//  UsersAPI.swift
//  DesafioSafra
//
//  Created by Renato Ferraz on 30/04/21.
//

import Foundation

class UsersAPI {
    private let manager: RequestManager
    
    init(manager: RequestManager) {
        self.manager = manager
    }
    
    func getUser(username: String, completion: @escaping (Result<User,Error>)->Void) {
        let urlString = GithubAPISources.users(username: username).getURL()
        
        switch urlString {
        case .success(let url):
            manager.requestDecodable(url: url, method: .get, parameters: [:], headers: [:], completion: completion)
        case .failure(let error):
            completion(.failure(error))
        }
        
       
    }
    
}

