//
//  GithubAPIBuilder.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 22/02/21.
//

import Foundation

public class GithubAPIBuilder {

    private var url: String
    
    public init() {
        url = "https://api.github.com"
    }
    
    func searchRepositories() -> GithubAPIBuilder {
        self.url += "/search/repositories"
        return self
    }
    
    func queryByLanguage(languague: String) -> GithubAPIBuilder {
        self.url += "?q=language:" + languague
        return self
    }
    
    func sortByStars() -> GithubAPIBuilder {
        self.url += "&sort=stars"
        return self
    }
    
    func page(page: Int) -> GithubAPIBuilder {
        self.url += "&page=\(page)"
        return self
    }
    
    func buildURL() -> String {
        return self.url
    }
    
    func pullsRequestURL(url: String) -> String {
        return url.replacingOccurrences(of: "{/number}", with: "")
    }
}
