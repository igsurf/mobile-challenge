//
//  GithubAPIMapper.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 22/02/21.
//

import Foundation

public class GithubAPIMapper {
    static func decode(repositories fromJSON: Dictionary<String, Any>) -> GithubRepositoriesResponseModel? {
        if let jsonData: Data =  try? JSONSerialization.data(withJSONObject: fromJSON, options: .prettyPrinted) {
            do {
                let codable = try JSONDecoder().decode(GithubRepositoriesResponseModel.self, from: jsonData)
                return codable
            } catch {
                RGLog.d(error)
            }
        }
        return nil
    }
    
    static func decode(pullRequests fromJSON: [Dictionary<String, Any>]) -> [PullRequestResponseModel]? {
        if let jsonData: Data =  try? JSONSerialization.data(withJSONObject: fromJSON, options: .prettyPrinted) {
            do {
                let codable = try JSONDecoder().decode([PullRequestResponseModel].self, from: jsonData)
                return codable
            } catch {
                RGLog.d(error)
            }
        }
        return nil
    }
}
