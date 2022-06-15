//
//  REST.swift
//  GithubJavaPopV2
//
//  Created by Suh on 13/06/22.
//

import Foundation


struct REST {
    
    static private let basepath = "https://api.github.com"
    
    static func loadRepository(onComplete: @escaping (Repositories? ) -> Void) {
        let path = basepath + "/search/repositories?q=language:Java&sort=stars&page=1"
        guard let url = URL(string: path) else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil {
                guard let response = response as? HTTPURLResponse else { return }
                if response.statusCode >= 200 && response.statusCode < 300 {
                    guard let data = data else { return }
                    do {
                        let decode = JSONDecoder()
                        decode.keyDecodingStrategy = .convertFromSnakeCase
                        let repository = try decode.decode(Repositories.self, from: data)
                        onComplete(repository)
                    } catch {
                        print(error.localizedDescription)
                    }
                } else {
                    print("Algum status inválido pelo servidor!!")
                }
            } else {
                print(error!)
            }
        }
        dataTask.resume()
    }
    
    static func loadPullRequest(owner: String, repository: String, onComplete: @escaping ([PullRequest]?) -> Void) {
        let path = basepath + "/repos/" + owner + "/" + repository + "/pulls"
        guard let url = URL(string: path) else { return }
        let datatask = URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil {
                guard let response = response as? HTTPURLResponse else { return }
                if response.statusCode == 200 {
                    guard let data = data else { return }
                    let decoder = JSONDecoder()
                    do{
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let pullRequest = try decoder.decode([PullRequest].self, from: data)
                        onComplete(pullRequest)
                    } catch {
                        print(error.localizedDescription)
                    }
                } else {
                    print("Algum status inválido pelo servidor!!")
                }
            } else {
                print(error!)
            }
        }
        datatask.resume()
    }

    
}
