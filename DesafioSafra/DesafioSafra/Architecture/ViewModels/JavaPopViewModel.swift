//
//  JavaPopViewModel.swift
//  DesafioSafra
//
//  Created by Renato Ferraz on 27/04/21.
//

import Foundation

struct JavaPopViewModel {
     
    var items: [Items] = []
    var userNames: [String] = []
    var nextLink: String?
    
    let apiRepo: StarsRepositoriesAPI?
    let apiUser: UsersAPI?
    let group = DispatchGroup()
    
    @available(iOS 13.0, *)
    mutating func getRepos(urlString: String, completion: @escaping (Result<[Items], Error>, String?)-> Void) {
        apiRepo?.getStarsRepos(link: urlString, completion: { result, nextLink in
            switch result {
            case .success(let repos):
                completion(.success(repos.items!), nextLink)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                completion(.failure(error),nextLink)
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
