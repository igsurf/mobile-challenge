//
//  ServiceRepository.swift
//  GithubJavaPopV3
//
//  Created by Suh on 08/07/22.
//

import Foundation

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
        
        network.requestData(using: request) { data in
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let repository = try decoder.decode(Repositories.self, from: data)
                onComplete(repository)
            } catch {
                onError(error)
            }

        } onError: { error in
            onError(error)
        }
    }
    
}
