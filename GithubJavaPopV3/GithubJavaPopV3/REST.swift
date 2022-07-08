//
//  REST.swift
//  GithubJavaPopV3
//
//  Created by Suh on 05/07/22.
//

import Foundation

struct REST {
    static private let base = "https://api.github.com"
    
    static func loadRepositories(onComplete: @escaping (Repositories?) -> Void) {
        let path = base + "/search/repositories?q=language:Java&sort=stars&page=1"
        guard let url = URL(string: path) else { return}
        let datatask = URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil {
                guard let response = response as? HTTPURLResponse else { return }
                if response.statusCode >= 200 && response.statusCode < 300 {
                    guard let data = data else { return }
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let repository = try decoder.decode(Repositories.self, from: data)
                        onComplete(repository)
                    } catch {
                        print(error.localizedDescription)
                    }
                } else {
                    print("Algum problema no servidor!")
                }
            } else {
                print(error!)
            }
        }
        datatask.resume()
    }
}
