//
//  GithubRepositoriesManager.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 22/02/21.
//

import Foundation

typealias GithubRepositoriesHandler = ((GithubRepositoriesResponseModel?) -> Void)

protocol GithubRepositoriesManagerInput {
    func get(language: String, page: Int, completion: @escaping GithubRepositoriesHandler)
}

public class GithubRepositoriesManager: GithubRepositoriesManagerInput {
    var object: GithubRepositoriesResponseModel? = GithubRepositoriesResponseModel()
    
    func get(language: String, page: Int, completion: @escaping GithubRepositoriesHandler) {
        GithubAPI.instance.getRepositoriesByLanguage(language: language, page: page, completion: { object in
            self.object = object
            completion(object)
        })
    }
}
