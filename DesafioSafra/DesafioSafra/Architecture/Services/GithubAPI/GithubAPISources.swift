//
//  GithubAPISources.swift
//  DesafioSafra
//
//  Created by Renato Ferraz on 30/04/21.
//

import Foundation

protocol APISource {
    func getURL() -> Result<URL,Error>
}

enum GithubAPISources {
    case starsRepositories(lenguage: String)
    case starsRepositoriesPagination(urlString: String)
    case users(username: String)
    case pulls(urlString: String)
}

extension GithubAPISources: APISource {
    func getURL() -> Result<URL, Error> {
        switch (self) {
        case .starsRepositories(let lenguage):
            let urlString = "https://api.github.com/search/repositories?q=language:@&sort=stars"
            
            let url: URL? = {
                guard let url = URL(string: urlString.replacingOccurrences(of: "@", with: lenguage)) else {
                    debugPrint("A url Usando não está válida: \(GithubAPISources.self)")
                    return nil
                }
                return url
            }()
            
            if let url = url {
                return .success(url)
            }else{
                return .failure(ServiceError.emptyData)
            }
            
        case .starsRepositoriesPagination(let urlString):
            let url: URL? = {
                guard let url = URL(string: urlString) else {
                    debugPrint("A url Usando não está válida: \(GithubAPISources.self)")
                    return nil
                }
                return url
            }()
            
            if let url = url {
                return .success(url)
            }else{
                return .failure(ServiceError.emptyData)
            }
            
        case .users(let username):
            let urlString = "https://api.github.com/users/@"
            
            let url: URL? = {
                guard let url = URL(string: urlString.replacingOccurrences(of: "@", with: username)) else {
                    debugPrint("A url Usando não está válida: \(GithubAPISources.self)")
                    return nil
                }
                return url
            }()
            
            if let url = url {
                return .success(url)
            }else{
                return .failure(ServiceError.emptyData)
            }
            
        case .pulls(let urlString):
            let url: URL? = {
                guard let url = URL(string: urlString.replacingOccurrences(of: "{/number}", with: "")) else {
                    debugPrint("A url Usando não está válida: \(GithubAPISources.self)")
                    return nil
                }
                return url
            }()
            
            if let url = url {
                return .success(url)
            }else{
                return .failure(ServiceError.emptyData)
            }
        }
    }
}
