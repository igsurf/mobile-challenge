//
//  GithubAPI.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 22/02/21.
//

import Foundation

public class GithubAPI {
    
    public static let instance: GithubAPI = GithubAPI()
    
    private init(){}
    
    func getRepositoriesByLanguage(language: String, page: Int, completion: @escaping GithubRepositoriesHandler) {
        let url = GithubAPIBuilder().searchRepositories().queryByLanguage(languague: language).sortByStars().page(page: page).buildURL()
        NetworkRequest.instance.get(url: url, headers: nil, completion: { json in
            if let respJSON = json as? Dictionary<String, Any> {
                if let result = GithubAPIMapper.decode(repositories: respJSON) {
                    completion(result)
                } else {
                    RGLog.d("Erro ao parsear a resposta da API.")
                    completion(nil)
                }
            } else {
                RGLog.e("Erro ao parsear JSON: \(json)")
                completion(nil)
            }
        })
    }
    
    func getPullsRequest(url: String, completion: @escaping GithubPullsRequestsHandler) {
        let url = GithubAPIBuilder().pullsRequestURL(url: url)
        NetworkRequest.instance.get(url: url, headers: nil, completion: { json in
            if let respJSON = json as? [Dictionary<String, Any>] {
                if let result = GithubAPIMapper.decode(pullRequests: respJSON){
                    completion(result)
                } else {
                    RGLog.d("Erro ao parsear a resposta da API.")
                    completion(nil)
                }
            } else {
                RGLog.e("Erro ao parsear JSON: \(json)")
                completion(nil)
            }
        })
    }
}
