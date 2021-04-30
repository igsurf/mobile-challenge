//
//  PullsApi.swift
//  DesafioSafra
//
//  Created by Renato Ferraz on 30/04/21.
//

import Foundation

class PullsApi {
    private let manager: RequestManager
    
    init(manager: RequestManager) {
        self.manager = manager
    }
    
    func getPulls(urlString: String, completion: @escaping (Result<[PullRequest],Error>)->Void) {
        let urlString = GithubAPISources.pulls(urlString: urlString).getURL()
        
        switch urlString {
        case .success(let url):
            manager.requestDecodable(url: url, method: .get, parameters: [:], headers: [:], completion: completion)
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
}
