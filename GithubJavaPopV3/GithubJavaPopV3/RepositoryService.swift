//
//  ServiceRepository.swift
//  GithubJavaPopV3
//
//  Created by Suh on 08/07/22.
//

import Foundation
import AVFoundation

class RepositoryService {
    private let network: Network
    
    init(network: Network = Network.shared) {
        self.network = network
    }
    
    func fetchRepositories(
        page: Int,
        onComplete: @escaping (Repositories) -> Void,
        onError: @escaping (Error) -> Void
    ) {
        let request =  Request.init(
            baseURL: Config.baseURL,
            path: "search/repositories?q=language:Java&sort=stars&page=\(page)" ,
            method: RequestMethod.get
        )
        
        network.request(request: request, returning: Repositories.self) { result in
            switch result {
            case .failure(let error):
                onError(error)
            case .success(let repositories):
                onComplete(repositories ?? Repositories(items: []))
            }
        }
    }
    
}
