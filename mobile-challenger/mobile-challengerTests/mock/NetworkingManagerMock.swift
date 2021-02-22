//
//  NetworkingManagerMock.swift
//  mobile-challengerTests
//
//  Created by Leonardo Sugano on 21/02/21.
//

import UIKit
@testable import mobile_challenger

class NetworkingManagerMock: NetworkingManager {
    
    
    override func getRepositories(page: Int, success: @escaping ([RepositoriesModel]) -> Void, error: @escaping (String) -> Void) {
        success(ModelsMock.setGetRepositoriesMockResponse())
        error("error mocado")
    }
    
    override func getPullRequest(page: Int, nameUrl: String, success: @escaping ([PullRequestModel]) -> Void, error: @escaping (String) -> Void) {
        success(ModelsMock.setPullRequestMockResponse())
        error("error mocado")
    }
}
